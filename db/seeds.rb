# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Borrando tablas intermedias
Manage.destroy_all
Baseline.destroy_all
Work.destroy_all
Measure.destroy_all
Detob.destroy_all
Detail.destroy_all
Report.destroy_all
Help.destroy_all

# Measure
measure_Un = Measure.create({me_name: "Unidad", me_unit: "UN", me_is_active: true, created_at: Time.now, updated_at: Time.now})
measure_m3 = Measure.create({me_name: "Metro cubico", me_unit: "m3", me_is_active: true, created_at: Time.now, updated_at: Time.now})
measure_Gl = Measure.create({me_name: "Global", me_unit: "Glb.", me_is_active: true, created_at: Time.now, updated_at: Time.now})
measure_Gl = Measure.create({me_name: "Metro lineal", me_unit: "m", me_is_active: true, created_at: Time.now, updated_at: Time.now})

# Devise Users
User.destroy_all
admon_user = User.create(
    {   us_name:    "Admin", 
        email:      "soporte@csinteligente.com", 
        password:   "4dm0n2019$", 
        us_rol:     User.us_rols[:admin], 
        us_status:  1 
    })
client_user = User.create(
    {
        us_name: "Client Dummy", 
        email: "client_dummy@mail.com", 
        password: "Cl1ent", 
        us_rol: User.us_rols[:client], 
        us_status: 1 
    })
contractor_user = User.create(
    {
        us_name: "Contractor Dummy", 
        email: "contractor_dummy@mail.com", 
        password: "C0ntr4ct0r", 
        us_rol: User.us_rols[:contractor], 
        us_status: 1 
    })

    interventor_user = User.create(
    {
        us_name: "Interventor Dummy", 
        email: "interventor_dummy@mail.com", 
        password: "1nt3rv3nt0r", 
        us_rol: User.us_rols[:interventor], 
        us_status: 1 
    })
p "# Seed Created #{User.count} Users"

Project.destroy_all
dummy_project = Project.create(
    {
        pr_name: 'Dummy Project', 
        pr_description: 'Description dummy project', 
        pr_start_date: DateTime.strptime("04/14/2015", "%m/%d/%Y"), 
        pr_end_date: nil, 
        pr_admon: '0.1', 
        pr_incidental: '0.2', 
        pr_indirect_cost: '0.3', 
        pr_profit: '0.4', 
        pr_tax_iva: '0.4', 
        created_at: Time.now, 
        updated_at: Time.now
    })
p "# Seed Created #{Project.count} Projects"

Manage.create({user_id: admon_user.id, project_id: dummy_project.id, created_at: Time.now, updated_at: Time.now})
Manage.create({user_id: interventor_user.id, project_id: dummy_project.id, created_at: Time.now, updated_at: Time.now})
Manage.create({user_id: client_user.id, project_id: dummy_project.id, created_at: Time.now, updated_at: Time.now})
Manage.create({user_id: contractor_user.id, project_id: dummy_project.id, created_at: Time.now, updated_at: Time.now})
p "# Seed Created #{Manage.count} Manages"

Baseline.destroy_all
Activity.destroy_all

# Collaborator
Collaborator.destroy_all
collaborators = Collaborator.create(
    [
        { co_name: 'Ayudantes Civil' }, 
        { co_name: 'Oficiales Civil' },
        { co_name: 'Almacenista' },
        { co_name: 'Capataz de Obra civil' },
        { co_name: 'Ingeniero  Residente Obra Civil ' },
        { co_name: 'Enfermero' },
        { co_name: 'Conexionistas' },
        { co_name: 'Ayudante Eléctricos' },
        { co_name: 'Ingeniero Oficina Técnica' },
        { co_name: 'Inspector Civil' },
        { co_name: 'Conductores' },
        { co_name: 'Topógrafo' },
        { co_name: 'Ingeniero Residente Electromecánico' },
        { co_name: 'Director de Proyecto' },
        { co_name: 'Auxiliar Compras' }
    ]
)
p "# Seed Created #{collaborators.count} Collaborators"

# Equipment
Equipment.destroy_all
equipments = Equipment.create(
    [
        { eq_name: 'Vibrador de concreto' },
        { eq_name: 'Cortadora de ladrillo' },
        { eq_name: 'Planta eléctrica' },
        { eq_name: 'Camioneta' },
        { eq_name: 'Ambulancia' },
        { eq_name: 'Volqueta' },
        { eq_name: 'Compresor' },
        { eq_name: 'Unidad llenado de gas' },
        { eq_name: 'Grúa' },
        { eq_name: 'Vibrocompactador tipo canguro' },
        { eq_name: 'Concretadora' },
        { eq_name: 'Motobomba' }
    ]
)
p "# Seed Created #{equipments.count} Equipments"


# Weather
Weather.destroy_all
weathers = Weather.create(
    [
        { we_name: 'Mañana por lluva' },
        { we_name: 'Tarde por lluvia' },
        { we_name: 'Otros motivos' }
    ]
)
p "# Seed Created #{weathers.count} Weathers"

# Weather
Qaqc.destroy_all
qaqcs = Qaqc.create(
    [
        { qa_name: 'Q1' },
        { qa_name: 'Q2' },
        { qa_name: 'Q3' }
    ]
)
p "# Seed Created #{qaqcs.count} Qaqcs"

# Observation 1 = Collaborator, 2 = Equipo, 3 = Weather, 4 = QaQc
Observation.destroy_all
observations = Observation.create(
    [
        { ob_name: 'Insuficiente', ob_type: '1' },
        { ob_name: 'Accidente', ob_type: '1' },
        { ob_name: 'Falta de implementos', ob_type: '1' },
        { ob_name: 'Paro', ob_type: '1' },
        { ob_name: 'Defectuoso', ob_type: '2' },
        { ob_name: 'Insuficiente', ob_type: '2' },
        { ob_name: 'Mantenimiento', ob_type: '2' },
        { ob_name: 'Clima', ob_type: '3' },
        { ob_name: 'Ingeniero faltante', ob_type: '4' },
        { ob_name: 'Paro comunidad', ob_type: '4' },
        { ob_name: 'Cambio programación', ob_type: '4' },
        { ob_name: 'Faltan materiales', ob_type: '4' },
        { ob_name: 'Faltan certificados', ob_type: '4' },
        { ob_name: 'Evento imprevisto', ob_type: '4' },
        { ob_name: 'Cambio alcance', ob_type: '4' },
        { ob_name: 'Falta de pruebas', ob_type: '4' },
        { ob_name: '', ob_type: '4' }

    ]
)
p "# Seed Created #{observations.count} Observations"
