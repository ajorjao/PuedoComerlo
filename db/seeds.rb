
User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true")

#no mover el orden de las intolerancias
Intolerance.create(name: "lactosa", minor_symptom: "", medium_symptom: "Náuseas
	Dolor abdominal
	Espasmos
	Hinchazón y distensión abdominal
	Gases abdominales y flatulencias
	Diarreas ácidas
	Heces pastosas y flotantes
	Defecación explosiva
	Vómitos
	Enrojecimiento periana", major_symptom: "", key_components: ["lactosa","lactose","leche","milk"])
=begin
# Intolerance.create(name: "gluten", minor_symptom: "", medium_symptom: "Diarrea crónica
	Hinchazón abdominal
	Estreñimiento
	Náuseas y vómitos
	Anemia
	Debilidad generalizada
	Erupciones cutáneas
	Estreñimiento
	Dolor de cabeza
	Alteraciones del esmalte dental
	Raquitismo
	Fracturas espontáneas", major_symptom: "", key_components: [])

# Intolerance.create(name: "mani", minor_symptom: "", medium_symptom: "Dolor estomacal
	Goteo nasal
	Picazón de ojos
	Ronchas (Urticaria) u hormigueo en los labios o la lengua", major_symptom: "", key_components: [])

# Intolerance.create(name: "nueces", minor_symptom: "", medium_symptom: "Picazón o hinchazón de la boca, la lengua o los labios
	Reacciones en la piel (Eccema, urticaria, hinchazón y enrojecimiento de la cara o las extremidades)
	Los síntomas gastrointestinales (Dolor abdominal, náuseas, vómitos, diarrea)
	Los síntomas respiratorios (Secreción o congestión nasal, tos, estornudos, respiración sibilante, dificultad para respirar)
	Los síntomas cardiovasculares (Caída en la presión arterial, mareos, desmayos)", major_symptom: "", key_components: [])
=end

Intolerance.create(name: "apio", minor_symptom: "", medium_symptom: "Vómitos
	Diarrea
	Erupciones en la piel
	Inflamación de las vías respiratorias
	Disminución de la presión arterial
	Reacción anafiláctica", major_symptom: "", key_components: ["apio","apium","graviolens","celery"])

=begin
# Intolerance.create(name: "mostaza", minor_symptom: "", medium_symptom: "Urticaria
	Eccema
	Asma bronquial
	Dolor gástrico
	Shock anafiláctico", major_symptom: "", key_components: [])

# Intolerance.create(name: "huevo", minor_symptom: "", medium_symptom: "Reacciones cutáneas
    Síntomas gastrointestinales agudos y respiratorios
    Reacción generalizada de anafilaxia (Junto con hipotensión, colapso vascular y disrritmias cardiacas)", major_symptom: "", key_components: [])

# Intolerance.create(name: "sesamo", minor_symptom: "", medium_symptom: "Dermatitis de contacto 
    Urticaria
    Rinitis alérgica
    Asma
    Dermatitis atópica
    Anafilaxia", major_symptom: "", key_components: [])

# Intolerance.create(name: "pescado", minor_symptom: "", medium_symptom: "Hinchazón de los labios
	Prurito o picor en la cavidad bucal
	Dificultad para deglutir
	Urticaria
	Rinitis
	Dolor abdominal
	Diarrea
	Ronchas graves
	Dificultad respiratoria y asma
	Náuseas y vómitos", major_symptom: "", key_components: [])

# Intolerance.create(name: "crustaceos", minor_symptom: "", medium_symptom: "Urticaria aguda
	Asma
	Rinitis
	Anafilaxia
	Síndrome de alergia oral", major_symptom: "", key_components: [])

# Intolerance.create(name: "mariscos", minor_symptom: "", medium_symptom: "Urticaria aguda
	Asma
	Anafilaxia
	Síndrome de alergia oral", major_symptom: "", key_components: [])

# Intolerance.create(name: "soya", minor_symptom: "", medium_symptom: "Hinchazón en labios, cara, lengua, garganta y otras partes del cuerpo
    Hormigueo en la boca
    Problemas de piel: urticaria, eczema o picazón
    Úlceras en la boca
    Dificultad para respirar y/o respiración sibilante
    Dolor abdominal acompañado con diarrea, náuseas o vómitos
    Mareos y desvanecimientos
    Fuerte caída de la presión arterial
    Pulso rápido o taquicardia
    Pérdida del conocimiento
    Aturdimiento
    Anafilaxia: constricción de las vías respiratorias, incluyendo la inflamación de garganta", major_symptom: "", key_components: [])

# Intolerance.create(name: "sulfitos", minor_symptom: "", medium_symptom: "Estornudos
	Secreción nasal (rinorrea)
	Prurito (picor)
	Erupción (aparecen granos, como urticaria)
	Dolor abdominal o posiblemente asma", major_symptom: "", key_components: [])
=end
Intolerance.create(name: "legumbres", minor_symptom: "", medium_symptom: "Síndrome de alergia oral
	Urticaria
	Angioedema
	Rinitis
	Crisis asmáticas
	Anafilaxia", major_symptom: "", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins","lupino"])

# Product.first.intolerances << Intolerance.first

Company.create(id: 7802900295, name: "soprole", url: "http://www.soprole.cl/productos?page=1")
Company.create(id: 7801810, name: "lipton")
Company.create(id: 78020000, name: "lays")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")