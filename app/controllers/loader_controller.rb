class LoaderController < ApplicationController
  include HTTParty

  def new
    require 'aws-sdk'
    require 'json'
    creds = JSON.load(File.read('secrets.json'))
    Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
    s3 = Aws::S3::Client.new
    s3.list_objects(bucket:'csinteligente.data.com').each do |response|
      puts response.contents.map(&:key)
      @files_item = response.contents.map(&:key)
    end
  end

  def create
    require 'open-uri'
    p "# PDT file   #{params[:pdt_name]}  "
    p "# COST file  #{params[:cost_name]} "
    puts params[:pdt_name]
    puts params[:cost_name]
    
    p "# Starting loading xml ... "
    # console: params = {"pdt_name": "PDT_DISEMCO_REV0.xml", "cost_name": "CUADRO_FACTURA.csv"}
    doc_pdt = Nokogiri::XML(open('https://s3.amazonaws.com/csinteligente.data.com/'+params[:pdt_name]))
    
    
    puts "## Title:  #{doc_pdt.xpath('//xmlns:Title').text} "

    p "# Starting loading csv ... "
    
    csvDataBody     = HTTParty.get('https://s3.amazonaws.com/csinteligente.data.com/'+params[:cost_name]).body
    csvTableMatrix  = CSV.parse(csvDataBody, headers: true).to_a()
    


    # doc = Nokogiri::XML(open("#{Rails.root}/PDT_DISEMCO_REV.xml"))
    doc_pdt.xpath('//xmlns:Title').text
    tasks = doc_pdt.xpath('//xmlns:Task')
    

    require 'date'
    startDate           = DateTime.parse(doc_pdt.xpath('//xmlns:StartDate').text)
    formatted_startDate = startDate.strftime('%Y-%m-%d-T%H:%M:%S')
    finishDate          = DateTime.parse(doc_pdt.xpath('//xmlns:FinishDate').text)
    formatted_endDate   = finishDate.strftime('%Y-%m-%d-T%H:%M:%S')

    main_project = Project.create(
      {
          pr_name:          doc_pdt.xpath('//xmlns:Title').text, 
          pr_description:   'Proyecto cargado desde PDT', 
          pr_start_date:    startDate, 
          pr_end_date:      finishDate, 
          pr_admon:         '0', 
          pr_incidental:    '0', 
          pr_indirect_cost: '0', 
          pr_profit:        '0', 
          pr_tax_iva:       '0', 
          created_at:       Time.now, 
          updated_at:       Time.now
      })
    p "# main_project #{main_project.pr_name}"

    admon = User.where(us_name: 'Admin')
    last_manage = Manage.create({ 
     user_id: admon[0].id,
     project_id: main_project.id,
     created_at: Time.now,
     updated_at: Time.now
    })
    p "# last_manage #{last_manage.user_id}"
    
    actual_contract_item_xml  = ""
    actual_amount             = ""
    actual_unit               = ""
    actual_value              = ""
    # Root Activity
    root_activity = nil

    tasks.each do |node|
      # console: tasks[0].css("ManualStart").text
      # console: tasks[3].css("ExtendedAttribute")
      # console: extendedAttributeNodes = tasks[3].css("ExtendedAttribute")
      # console: extendedAttributeNodes.length
      # console: tasks[3].css("ExtendedAttribute")[3].css("Value").text

      extendedAttributeNodes = node.css("ExtendedAttribute")
      # console: extendedAttributeNodes = tasks[0].css("ExtendedAttribute")
      # p "# longitud: #{extendedAttributeNodes.length} "
      if (extendedAttributeNodes.length > 0) then
        actual_contract_item_xml = extendedAttributeNodes[0].css("Value").text
        p "## Value #{extendedAttributeNodes[0].css("Value").text}"
        # csvTableMatrix.find_index(actual_contract_item_xml);
        for i in 1..csvTableMatrix.length - 1 do
          # p "### csvTableMatrix[i][0]: #{csvTableMatrix[i][0]} "
          # p "### actual_contract_item_xml: #{actual_contract_item_xml}"
          if actual_contract_item_xml == csvTableMatrix[i][0] then
            p "### Are equal... in          : #{i}"
            p "### csvTableMatrix[i][0]     : #{csvTableMatrix[i][0]}"
            p "### actual_contract_item_xml : #{actual_contract_item_xml}"
            p csvTableMatrix[i][2]
            # actual_unit   = if csvTableMatrix[i][6].nil? then nil else csvTableMatrix[i][6] end
            actual_unit   = csvTableMatrix[i][6].nil? ? nil : csvTableMatrix[i][6]  
            actual_amount = if csvTableMatrix[i][7].nil? then nil else csvTableMatrix[i][7] end
            actual_value  = if csvTableMatrix[i][7].nil? then nil else csvTableMatrix[i][8].gsub(" ","").gsub("$","").gsub(",","") end
            p "### actual_unit    : #{actual_unit}"
            p "### actual_amount  : #{actual_amount}"
            p "### actual_value   : #{actual_value}"
            break
          else 
            p "### Are NOT equal... "
            actual_unit   = nil
            actual_amount = nil
            actual_value  = nil
          end
        end
      else
        actual_unit   = nil
        actual_amount = nil
        actual_value  = nil
      end

      p "# actual_unit:   #{actual_unit}"
      p "# actual_amount: #{actual_amount}"
      p "# actual_value:  #{actual_value}"

      # Dates
      activityStartDate             = DateTime.parse(node.css("ManualStart").text)
      activity_formatted_startDate  = activityStartDate.strftime('%Y-%m-%d-T%H:%M:%S')
      activityFinishDate            = DateTime.parse(node.css("ManualFinish").text)
      activity_formatted_endDate    = activityFinishDate.strftime('%Y-%m-%d-T%H:%M:%S')
      # Parent activity
      # console: tasks[0].css("WBS").text
      # For activities
      new_ac_numbered_list  = ""
      new_ac_name           = ""
      new_activity_parent   = nil
      # For base
      new_ba_project_id   = nil
      new_ba_activity_id  = nil
      new_ba_status       = ""
      new_ba_type         = ""
      new_ba_amount       = ""
      new_ba_price        = nil
      new_baseline_id     = nil
      new_measure_id      = nil
      if !actual_unit.nil? then
        me_un = Measure.where(me_unit: actual_unit)
        if me_un.length > 0 then
          new_measure_id = me_un[0].id
        else
          new_measure_id = nil
        end
      end
      
      if node.css("WBS").text == "0" then
        p "## Is root"
        new_ac_numbered_list = node.css("WBS").text
        new_ac_name          = node.css("Name").text
        new_activity_parent  = nil
        
        new_ba_project_id = main_project.id
        new_ba_status     = "xml_loaded"
        new_ba_type       = "root"
        new_ba_amount     = actual_amount
        new_ba_price      = actual_value
        new_baseline_id   = nil
        new_measure_id    = new_measure_id
      else
        wbs_split = node.css("WBS").text.split(".")
        if wbs_split.length == 1 then
          p "## Is root child"
          new_ac_numbered_list  = node.css("WBS").text
          new_ac_name           = node.css("Name").text
          new_activity_parent   = if root_activity.nil? then nil else root_activity end

          new_ba_project_id = main_project.id
          new_ba_status     = "xml_loaded"
          new_ba_type       = "child"
          new_ba_amount     = actual_amount
          new_ba_price      = actual_value
          new_baseline_id   = nil
        else
          p "## Is leave"
          new_ac_numbered_list      = node.css("WBS").text
          new_ac_name               = node.css("Name").text
          new_activity_parent_temp  = main_project.activities.where(ac_numbered_list: helpers.getParent(wbs_split).chomp("."))[0]
          new_activity_parent       = if new_activity_parent_temp.nil? then nil else new_activity_parent_temp end
          
          new_ba_project_id = main_project.id
          new_ba_status     = "xml_loaded"
          new_ba_type       = "child"
          new_ba_amount     = actual_amount
          new_ba_price      = actual_value
          new_baseline_id   = nil
        end
      end

      p " new_ac_numbered_list  :   #{new_ac_numbered_list}"
      p " new_ac_name           :   #{new_ac_name}"
      p " new_activity_parent   :   #{new_activity_parent}"
      p " new_ba_project_id     :   #{new_ba_project_id}"
      p " new_ba_status         :   #{new_ba_status}"
      p " new_ba_type           :   #{new_ba_type}"
      p " new_ba_amount         :   #{new_ba_amount}"
      p " new_ba_price          :   #{new_ba_price}"
      p " new_baseline_id       :   #{new_baseline_id}"
      
      last_activity = Activity.create({
        ac_numbered_list:   new_ac_numbered_list,
        ac_name:            new_ac_name,
        ac_start_date:      activityStartDate,
        ac_end_date:        activityFinishDate,
        activity_id:        if new_activity_parent.nil? then nil else new_activity_parent.id end,
        created_at:         Time.now,
        updated_at:         Time.now, 
        ac_predecessor:     nil,
        ac_days:            nil,
        ac_is_cost:         if new_measure_id.nil? then nil else true end
      })   
      
      # Keeping the root
      if last_activity.ac_numbered_list == "0" then
        root_activity = last_activity
      end
      Baseline.create({
        project_id:   main_project.id,
        activity_id:  last_activity.id,
        ba_status:    'xml_loaded',
        ba_type:      'child',
        ba_amount:    new_ba_amount,
        ba_price:     new_ba_price,
        baseline_id:  nil,
        created_at:   Time.now,
        updated_at:   Time.now,
        measure_id:   new_measure_id
      })
    end
  end

  def index
  end

end
