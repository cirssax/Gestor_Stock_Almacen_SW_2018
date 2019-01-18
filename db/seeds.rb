# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Usuarios
User.destroy_all
User.create([
    {
        email: "cristobal.saldiasr@utem.cl",
        encrypted_password: "$2a$11$W1IaAZSnZmwXgKWI4a61HuMSZ4u5tOl9bZjY883dykC7m4Ov6chPy",
        id_rol: 2,
        id_estado: 1,
        nombre_trabajador: "IGNACIO ANTONIO",
        apellidos_trabajador: "ROJAS MOLINA",
        fono: 90100787,
        domicilio: "AV GRECIA 1029",
        rut: "6491588-6"
    },
    {
        email: "cristobal.saldias@gmail.com",
        encrypted_password: "$2a$11$tNf/F1bVvc92EmkLh9QYbe//lFTjZiGjF4UWvvkZEVYlNjhSwyb1S",
        id_rol: 1,
        id_estado: 1,
        nombre_trabajador: "CRISTOBAL",
        apellidos_trabajador: "SALDIAS ROJAS",
        fono: 77348189,
        domicilio: "CONSISTORIAL 793",
        rut: "19244463-2"
    },
    {
        email: "rasa777@vtr.net",
        encrypted_password: "$2a$11$EudvU6LA1V1g9GQa21F9wOyHZewWwB4XMRV7vvQRurAj0bITm8rpe",
        id_rol: 2,
        id_estado: 1,
        nombre_trabajador: "JOAQUIN",
        apellidos_trabajador: "AGUILERA ZAPATA",
        fono: 89738289,
        domicilio: "LOS HEROES 2030",
        rut: "20178334-8"
    },
    {
        email: "ljuo@rol.cl",
        encrypted_password: "$2a$11$Q2DVW.J42kzL89AIdDf0Jupgb6wgFIcKsgCRGjWXjy21Il0VMWnkC",
        id_rol: 2,
        id_estado: 1,
        nombre_trabajador: "ANDREA",
        apellidos_trabajador: "MOLINA BURGOS",
        fono: 123431123,
        domicilio: "AV GRECIA 1234",
        rut: "78045930-1"
    },
    {
        email: "cristobalisr@gmail.com",
        encrypted_password: "$2a$11$Sjnr71a/5e2hbBr0pkQc4.GtrtNDQMVe.GT/9OyWfmo21HBZPVdza",
        id_rol: 2,
        id_estado: 1,
        nombre_trabajador: "CAMILA ANDREA",
        apellidos_trabajador: "ESCARATE BURGOS",
        fono: 94386762,
        domicilio: "V GRECIA 2111, BLOC D, DPTO 12",
        rut: "9807445-7"
    }
            ])
p "Created #{User.cout} entries"
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
#Roles de usuarios
Role.destroy_all
Role.create([
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
State.create([
    {
        descrip_estado: "ACTIVO"
    },
    {
        descrip_estado: "DESACTIVADO"
    }
             ])
p "Created #{State.cout} entries"