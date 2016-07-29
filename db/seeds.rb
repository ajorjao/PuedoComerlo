# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true")


Intolerance.create(name: "lactosa", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: ["lactosa","lactose","leche","milk"])
# Intolerance.create(name: "gluten", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "mani", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "nueces", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
Intolerance.create(name: "apio", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: ["apio","apium","graviolens","celery"])
# Intolerance.create(name: "mostaza", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "huevo", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "sesamo", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "pescado", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "crustaceos", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "mariscos", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "soya", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
# Intolerance.create(name: "sulfitos", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: [])
Intolerance.create(name: "legumbres", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins"])


Company.create(id: 7802900295, name: "soprole")
Company.create(id: 7801810, name: "lipton")
Company.create(id: 78020000, name: "lays")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")