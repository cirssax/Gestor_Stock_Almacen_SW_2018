# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Roles de usuarios
Role.destroy_all
Role.create!([
                {
                    descrip_rol: "ADMINISTRADOR"
                },
                {
                    descrip_rol: "VENDEDOR"
                }
            ])
p "Created #{Role.count} entries"
#Estados de usuarios
State.destroy_all
State.create!([
                 {
                     descrip_estado: "ACTIVO"
                 },
                 {
                     descrip_estado: "DESACTIVADO"
                 }
             ])
p "Created #{State.count} entries"

#Usuarios
User.destroy_all
User.create!([
    {
        email: "cristobal.saldiasr@utem.cl",
        password: '1234qwer',
        password_confirmation: '1234qwer',
        id_rol: (Role.find_by_descrip_rol("VENDEDOR")).id,
        id_estado: (State.find_by_descrip_estado("ACTIVO")).id,,
        nombre_trabajador: "IGNACIO ANTONIO",
        apellidos_trabajador: "ROJAS MOLINA",
        fono: 90100787,
        domicilio: "AV GRECIA 1029",
        rut: "6491588-6"
    },
    {
        email: "cristobal.saldias@gmail.com",
        password: '1234qwer',
        password_confirmation: '1234qwer',
        id_rol: (Role.find_by_descrip_rol("ADMINISTRADOR")).id,
        id_estado: (State.find_by_descrip_estado("ACTIVO")).id,
        nombre_trabajador: "CRISTOBAL",
        apellidos_trabajador: "SALDIAS ROJAS",
        fono: 77348189,
        domicilio: "CONSISTORIAL 793",
        rut: "19244463-2"
    },
    {
        email: "rasa777@vtr.net",
        password: '1234qwer',
        password_confirmation: '1234qwer',
        id_rol: (Role.find_by_descrip_rol("VENDEDOR")).id,
        id_estado: (State.find_by_descrip_estado("ACTIVO")).id,,
        nombre_trabajador: "JOAQUIN",
        apellidos_trabajador: "AGUILERA ZAPATA",
        fono: 89738289,
        domicilio: "LOS HEROES 2030",
        rut: "20178334-8"
    },
    {
        email: "ljuo@rol.cl",
        password: '1234qwer',
        password_confirmation: '1234qwer',
        id_rol: (Role.find_by_descrip_rol("VENDEDOR")).id,,
        id_estado: (State.find_by_descrip_estado("ACTIVO")).id,,
        nombre_trabajador: "ANDREA",
        apellidos_trabajador: "MOLINA BURGOS",
        fono: 123431123,
        domicilio: "AV GRECIA 1234",
        rut: "78045930-1"
    },
    {
        email: "cristobalisr@gmail.com",
        password: '1234qwer',
        password_confirmation: '1234qwer',
        id_rol: (Role.find_by_descrip_rol("VENDEDOR")).id,,
        id_estado: (State.find_by_descrip_estado("ACTIVO")).id,,
        nombre_trabajador: "CAMILA ANDREA",
        apellidos_trabajador: "ESCARATE BURGOS",
        fono: 94386762,
        domicilio: "V GRECIA 2111, BLOC D, DPTO 12",
        rut: "9807445-7"
    }
            ])
p "Created #{User.count} entries"
#Tipos de productos
Type.destroy_all
Type.create([
    {
        descrip_tipo: "HIGIENE"
    },
    {
        descrip_tipo: "OFICINA"
    },
    {
        descrip_tipo: "DEPORTE"
    },
    {
        descrip_tipo: "ESCOLAR"
    },
    {
        descrip_tipo: "ELECTRONICOS"
    },
    {
        descrip_tipo: "COCINA"
    },
    {
        descrip_tipo: "ROPA"
    },
    {
        descrip_tipo: "ABARROTES"
    }
            ])
p "Created #{Type.count} entries"
