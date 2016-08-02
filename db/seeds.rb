
User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true")

#no mover el orden de las intolerancias
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
Intolerance.create(name: "legumbres", minor_symptom: "", medium_symptom: "", major_symptom: "", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins","lupino"])

# Product.first.intolerances << Intolerance.first

Company.create(id: 7802900295, name: "soprole", url: "http://www.soprole.cl/productos?page=1")
Company.create(id: 7801810, name: "lipton")
Company.create(id: 78020000, name: "lays")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")