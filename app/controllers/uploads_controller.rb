class UploadsController < ApplicationController
  def new
  end

  def create

    if :file == nil
      puts "You must enter the name of the file to upload to S3!"
      exit
    end
  
    if S3_BUCKET.exists?
      name = params[:file].original_filename
      puts "## params[:file] '%s' to S3!" % params[:file]
      puts "## params[:file] '%s' to S3!" % params[:file].path
      # Check if file is already in bucket
      # if S3_BUCKET.object(name).exists?
        # puts "#{name} already exists in the bucket"
      # else
        obj = S3_BUCKET.object(name)
        # obj.upload_file(params[:file].path)
        obj.upload_file(params[:file].path, { acl: 'public-read' }) 
        puts "## Uploaded '%s' to S3!" % name
      # end
    else
      NO_SUCH_BUCKET % bucket_name
    end

    # # Make an object in your bucket for your upload
    # obj = S3_BUCKET.objects[params[:file].original_filename]

    # # Upload the file
    # obj.write(
    #   file: params[:file],
    #   acl: :public_read
    # )

    # # Create an object for the upload
    # @upload = Upload.new(
    # 		url: obj.public_url,
		# name: obj.key
    # 	)

    # # Save the upload
    # if @upload.save
    #   redirect_to uploads_path, success: 'File successfully uploaded'
    # else
    #   flash.now[:notice] = 'There was an error'
    #   render :new
    # end
  end

  def index
    #@files_item = []
    require 'aws-sdk'
    require 'json'
    creds = JSON.load(File.read('secrets.json'))
    Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
    s3 = Aws::S3::Client.new
    s3.list_objects(bucket:'csinteligente.data.com').each do |response|
      puts response.contents.map(&:key)
      @files_item = response.contents.map(&:key)
    end
    puts @files_item
    # p "# Starting reading xml ... "

    # doc = Nokogiri::XML(open("#{Rails.root}/PDT_DISEMCO_REV.xml"))
    # doc.xpath('//xmlns:Title').text
    # tasks = doc.xpath('//xmlns:Task')
    

    # require 'date'
    # startDate = DateTime.parse(doc.xpath('//xmlns:StartDate').text)
    # formatted_startDate = startDate.strftime('%Y-%m-%d-T%H:%M:%S')

    # finishDate = DateTime.parse(doc.xpath('//xmlns:FinishDate').text)
    # formatted_endDate = finishDate.strftime('%Y-%m-%d-T%H:%M:%S')

    # main_project = Project.create(
    #   {
    #       pr_name: doc.xpath('//xmlns:Title').text, 
    #       pr_description: 'Proyecto cargado desde PDT', 
    #       pr_start_date: startDate, 
    #       pr_end_date: finishDate, 
    #       pr_admon: '0', 
    #       pr_incidental: '0', 
    #       pr_indirect_cost: '0', 
    #       pr_profit: '0', 
    #       pr_tax_iva: '0', 
    #       created_at: Time.now, 
    #       updated_at: Time.now
    #   })
    # p "# main_project #{main_project.pr_name}"

    # # admon = CsUser.where(nickname: 'Administrator');
    # last_manage = Manage.create({ 
    #  cs_user_id: 97,
    #  project_id: main_project.id,
    #  created_at: Time.now,
    #  updated_at: Time.now
    # })
    # p "# last_manage #{last_manage.cs_user_id}"
    

    # tasks.each do |node|
    #   activityStartDate = DateTime.parse(node.css("ManualStart").text)
    #   activity_formatted_startDate = activityStartDate.strftime('%Y-%m-%d-T%H:%M:%S')

    #   activityFinishDate = DateTime.parse(node.css("ManualFinish").text)
    #   activity_formatted_endDate = activityFinishDate.strftime('%Y-%m-%d-T%H:%M:%S')
      
    #   last_activity = Activity.create({
    #     ac_numbered_list: node.css("WBS").text,
    #     ac_name: node.css("Name").text,
    #     ac_start_date: activityStartDate,
    #     ac_end_date: activityFinishDate,
    #     activity_id: nil,
    #     created_at: Time.now,
    #     updated_at: Time.now, 
    #     ac_predecessor: nil,
    #     ac_days: nil
    #   })   

    #   Baseline.create({
    #     project_id: main_project.id,
    #     activity_id: last_activity.id,
    #     ba_status: 'xml_loaded',
    #     ba_type: 'child',
    #     ba_amount: nil,
    #     ba_price: nil,
    #     baseline_id: nil,
    #     created_at: Time.now,
    #     updated_at: Time.now,
    #     measure_id: nil,
    #   })
    # end


    # # HTTParty
    # require 'httpParty'
    # xmlData = HTTParty.get('https://s3.amazonaws.com/csinteligente.data.com/PDT_DISEMCO_REV0.xml')
    # nokogiri_xml = Nokogiri::XML(xmlData)

    # doc = Nokogiri::XML(open('https://s3.amazonaws.com/csinteligente.data.com/PDT_DISEMCO_REV0.xml'))
  end
end