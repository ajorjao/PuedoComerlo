# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true")

Intolerance.create(name: "lactosa", key_components: ["lactosa","lactose","leche","milk"])
# Intolerance.create(name: "gluten", key_components: [])
# Intolerance.create(name: "mani", key_components: [])
# Intolerance.create(name: "nueces", key_components: [])
Intolerance.create(name: "apio", key_components: ["apio","apium","graviolens","celery")
# Intolerance.create(name: "mostaza", key_components: [])
# Intolerance.create(name: "huevo", key_components: [])
# Intolerance.create(name: "sesamo", key_components: [])
# Intolerance.create(name: "pescado", key_components: [])
# Intolerance.create(name: "crustaceos", key_components: [])
# Intolerance.create(name: "mariscos", key_components: [])
# Intolerance.create(name: "soya", key_components: [])
# Intolerance.create(name: "sulfitos", key_components: [])
Intolerance.create(name: "legumbres", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins"])

