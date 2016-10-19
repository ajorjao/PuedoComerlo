
User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true", username: "Administrador Jorge")
usuarioComun = User.create(email: "ajorjao123@gmail.com", password: "asdasd123", admin: "false", username: "Jorjo")
Family.create(name: "Jorjo", user_id: usuarioComun.id)

#no mover el orden de las intolerancias
lactosa = Intolerance.create(name: "Lactosa", minor_symptom: "", medium_symptom: "Náuseas, Dolor abdominal, Espasmos, Hinchazón y distensión abdominal, Gases abdominales y flatulencias, Diarreas ácidas, Heces pastosas y flotantes, Defecación explosiva, Vómitos, Enrojecimiento periana", major_symptom: "", key_components: ["lactosa","lactose","leche","milk"])

gluten = Intolerance.create(name: "Gluten", minor_symptom: "", medium_symptom: "Diarrea crónica, Hinchazón abdominal, Estreñimiento, Náuseas y vómitos, Anemia, Debilidad generalizada, Erupciones cutáneas, Estreñimiento, Dolor de cabeza, Alteraciones del esmalte dental, Raquitismo, Fracturas espontáneas", major_symptom: "", key_components: ["trigo", "centeno", "cebada", "escanda", "espelta", "triticale", "farro", "kamut", "espelta verde", "bulgur", "avena"])

mani = Intolerance.create(name: "Mani", minor_symptom: "", medium_symptom: "Dolor estomacal, Goteo nasal, Picazón de ojos, Ronchas (Urticaria) u hormigueo en los labios o la lengua", major_symptom: "", key_components: ["mani","cacahuate","peanut","frutos secos"])

nueces = Intolerance.create(name: "Nueces", minor_symptom: "", medium_symptom: "Picazón o hinchazón de la boca, la lengua o los labios, Reacciones en la piel (Eccema, urticaria, hinchazón y enrojecimiento de la cara o las extremidades), Los síntomas gastrointestinales (Dolor abdominal, náuseas, vómitos, diarrea), Los síntomas respiratorios (Secreción o congestión nasal, tos, estornudos, respiración sibilante, dificultad para respirar), Los síntomas cardiovasculares (Caída en la presión arterial, mareos, desmayos)", major_symptom: "", key_components: ["nuez","nut","nueces","frutos secos"])

apio = Intolerance.create(name: "Apio", minor_symptom: "", medium_symptom: "Vómitos, Diarrea, Erupciones en la piel, Inflamación de las vías respiratorias, Disminución de la presión arterial, Reacción anafiláctica", major_symptom: "", key_components: ["apio","apium","graviolens","celery"])

mostaza = Intolerance.create(name: "Mostaza", minor_symptom: "", medium_symptom: "Urticaria, Eccema, Asma bronquial, Dolor gástrico, Shock anafiláctico", major_symptom: "", key_components: ["mostaza","mustard"])

huevo = Intolerance.create(name: "Huevo", minor_symptom: "", medium_symptom: "Reacciones cutáneas, Síntomas gastrointestinales agudos y respiratorios, Reacción generalizada de anafilaxia (Junto con hipotensión, colapso vascular y disrritmias cardiacas)", major_symptom: "", key_components: ["egg","huevo", "lisozima", "albúmina", "coagulante", "emulsificante", "gloubina", "livetina", "ovoalbúmina", "ovomucina", "ovomucoide", "otransferrina", "ovovitelina", "vitelina", "e-16b,luteína", "pigmento amarillo"])

sesamo = Intolerance.create(name: "Sesamo", minor_symptom: "", medium_symptom: "Dermatitis de contacto, Urticaria, Rinitis alérgica, Asma, Dermatitis atópica, Anafilaxia", major_symptom: "", key_components: ["sésamo","ajonjolí","sesame"])

pescado = Intolerance.create(name: "Pescado", minor_symptom: "", medium_symptom: "Hinchazón de los labios, Prurito o picor en la cavidad bucal, Dificultad para deglutir, Urticaria, Rinitis, Dolor abdominal, Diarrea, Ronchas graves, Dificultad respiratoria y asma, Náuseas y vómitos", major_symptom: "", key_components: ["fish","pescado","[ESPECIES DE PESCADO???]"])

crustaceo = Intolerance.create(name: "Crustaceos", minor_symptom: "", medium_symptom: "Urticaria aguda, Asma, Rinitis, Anafilaxia, Síndrome de alergia oral", major_symptom: "", key_components: ["crustáceos","crustacean","[ESPECIES DE CRUSTACEOS???]"])

moluscos = Intolerance.create(name: "Moluscos", minor_symptom: "", medium_symptom: "Urticaria aguda, Asma, Anafilaxia, Síndrome de alergia oral", major_symptom: "", key_components: ["moluscos","molluscs","[ESPECIES DE MOLUSCOS????]"])

soya = Intolerance.create(name: "Soya", minor_symptom: "", medium_symptom: "Hinchazón en labios, cara, lengua, garganta y otras partes del cuerpo, Hormigueo en la boca, Problemas de piel: urticaria, eczema o picazón, Úlceras en la boca, Dificultad para respirar y/o respiración sibilante, Dolor abdominal acompañado con diarrea, náuseas o vómitos, Mareos y desvanecimientos, Fuerte caída de la presión arterial, Pulso rápido o taquicardia, Pérdida del conocimiento, Aturdimiento, Anafilaxia: constricción de las vías respiratorias, incluyendo la inflamación de garganta", major_symptom: "", key_components: ["soya", "mono-diglicerido", "soya", "soja", "yuba", "tsf" ,"harina de soya texturizada", "tsp" ,"proteína de soya texturizada","proteina de soya texturizada","tvp", "proteína vegetal texturizada", "lecitina", "msg", "lutamato monosodico"])

sulfitos = Intolerance.create(name: "Sulfitos", minor_symptom: "", medium_symptom: "Estornudos, Secreción nasal (rinorrea), Prurito (picor), Erupción (aparecen granos, como urticaria), Dolor abdominal o posiblemente asma", major_symptom: "", key_components: ["sulfitos","sulfites","Dióxido de azufre","E220","Sulfito sódico","E221","Sulfito ácido de sodio","E222","Metabisulfito sódico","Disulfito sódico","E223", "Metabisulfito potásico","Disulfito potásico","E224",  "Sulfito cálcico", "E226","Sulfito ácido de calcio","Bisulfito cálcico", "E227", "Sulfito ácido de potasio" ,"Bisulfito potásico" ,"E228"])

legumbres = Intolerance.create(name: "Legumbres", minor_symptom: "", medium_symptom: "Síndrome de alergia oral, Urticaria, Angioedema, Rinitis, Crisis asmáticas, Anafilaxia", major_symptom: "", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins","lupino"])
 
#no se si esto funciona!!!
# listaIntolerancias = ["legumbres", "sulfitos","soya"," moluscos" ,"crustaceo", "pescado", "sesamo", "huevo" ,"mostaza", "apio", "nueces" ,"mani" ,"gluten", "lactosa"]
#Company.create(id: , name: , url: "")

Company.create(name: "lipton", url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "lipton", url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Carte", url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Hellsman" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Malloa" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "JB" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Dorina" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Maizena" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Bonella" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Club" , url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Banda Azul", url: "http://www.unileverfoodsolutions.cl/productos-marcas/marcas")
Company.create(name: "Colun", url: "http://www.colun.cl/")

Company.create(name: "Vivo" , url: "http://www.vivo.cl/")
Company.create(name: "Quaker" , url: "http://www.quaker.cl/?page_id=7649")
Company.create(name: "Calan" , url: "http://www.calan.cl/productos/")

Company.create(name: "Savory", url: "https://www.savory.cl/productos")
Company.create(name: "Loncoleche", url: "http://www.loncoleche.cl/productos.html")

Company.create(name: "Deyco" , url: "http://www.deyco.cl/productos-deyco.html")
Company.create(name: "Coca Cola", url: "http://www.cocacoladechile.cl/")
Company.create(name: "Mundo San Jose" , url: "http://www.mundosanjose.cl/productos/")
#Company.create(id: , name: "Costa" , url: "")
#Company.create(id: , name: "Carozzi" , url: "")
#Company.create(id: , name: "Supremo" , url: "")
#Company.create(id: , name: "Kryspo" , url: "")
#Company.create(id: , name: "Ambrosoli" , url: "")
#Company.create(id: , name: "Sprim" , url: "")
#Company.create(id: , name: "Tratorri" , url: "")
#Company.create(id: , name: "Selecta" , url: "")
#Company.create(id: , name: "Miraflores" , url: "")
#Company.create(id: , name: "Maggi" , url: "")
#Company.create(id: , name: "Lucchetti" , url: "")
#Company.create(id: , name: "Caricia", url: "")


# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")
# Company.create(id: 780, name: "")

#PRODUCTOS
triton = Product.new(id: 7802230086952 ,name:"GALLETA TRITON VAINILLA 126 GR.",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Harina trigo, azucar, aceite animal parcialmente hidrog, almidon, cacao polvo, bicarbonato sodio, fosfato monocalcico, maltodextrina, sal, saborizante, lectina soya, colorante caramelo")
triton.image_from_url("http://ep.yimg.com/ca/I/yhst-62086439978846_2268_30439829")
triton.save

cocacola = Product.new(id: 7801610001936 ,name:"COCA COLA LATA",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, azucar, color caramelo, acido fosforico, saborizantes naturales y cafeina")
cocacola.image_from_url("https://www.corporativo.tia.com.ec/sites/almacenestia.com/files/productos/imagenescargadas/2014-10-18/247060.jpeg")
cocacola.save

golazo = Product.new(id: 7802200809178 ,name:"GOLAZO LECHE 25G",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Harina de arroz y trigo, azucar, leche en polvo, carbonato de calcio, sal . Relleno: azucar, manteca vegetal, leche en polvo, cacao en polvo, lecitina de soya")
golazo.image_from_url("http://ep.yimg.com/ca/I/yhst-62086439978846_2268_38909330")
golazo.save

ramitasQueso = Product.new(id: 7802000003479 ,name:"ramitas queso 42g",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Harina, aceite vegetal alto oleico, queso en polvo, aceite vegetal, sal, solidos de leche, azucar, emulsionante (estearil lactilato de sodio), antioxidante (TBHQ)")
ramitasQueso.image_from_url("http://ep.yimg.com/ca/I/yhst-62086439978846_2266_14837706")
ramitasQueso.save

aquariosManzana = Product.new(id: 7801610040294 ,name:"AQUARIUS MANZANA 500 ML",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azucar, jugo de manzana (10 m/m solidos solubles), acido citrico, polifosfato de sodio, acido malico, sorbato de potasio, citrato de sodio, benzoato de sodio, color caramelo, saborizante identico al natural y artificial, EDTA disodico calcico")
aquariosManzana.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Aquarius-Manzana-150x529-70x250.jpg")
aquariosManzana.save

lecheColun = Product.new(id: 7802920777542 ,name:"LECHE COLUN NATURAL 1 LT.",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida natural estandarizada")
lecheColun.image_from_url("http://pregrado.usistemas.cl/mejorprecio/images/632690ga.jpg")
lecheColun.save

nectar_manzana = Product.new(id: 7802575220516 ,name:"Nectar Manzana Vivo",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua,jugo de manzana clarificado, ácido cítrico, carboximetil celulosa sódica, ácido ascórbico, stevia, goma xanthan, sabor idéntico al natural de manzana, polidmetilsiloxano.")
nectar_manzana.image_from_url("http://www.vivo.cl/images/nectar3.png")
nectar_manzana.save


cerealbar_choco = Product.new(id: 7802215301452 ,name:"CerealBar Choco Cereal",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Harina de trigo, azúcar, polidextrosa, aceite vegeal, almidon de maiz, cacao en polvo, gelatina, aceite vegetal, glicerina, colorante natural, carbonato de calcio, lecitina de soya,leche entera en polvo, sal, ácido cítrico, gluten. ")
cerealbar_choco.image_from_url("http://www.dicsal.cl/wp-content/uploads/2016/02/CB-CHOC.png")
cerealbar_choco.save


spaguetti_vivo = Product.new(id: 7802575036018 ,name:"Pasta Spaghetti 5 Vivo",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Sémola de trigos duros seleccionados, mezcla multigranos 8% (gluten de trigo, fibra de avena, harina de cebada, harina de avena), betacaroteno.")
spaguetti_vivo.image_from_url("http://www.vivo.cl/images/pastas4.png")
spaguetti_vivo.save


yogurmora_calan = Product.new(id: 7802955004071 ,name:"YOGUR CALÁN BOLSA MORA 1 Kg",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida semidescremada, azúcar, espesante (almidón modificado), leche en polvo descremada, estabilizante (gelatina), saborizante idéntico a natural, colorantes naturales (carmín y clorofila), cultivos lácticos (Lactobacillus bulgaricus, Streptococcus termophilus), preservante (sorbato de potasio). Contiene: Leche y leche en polvo descremada. Puede contener trazas de: almendra, trigo, pasas, nuez.")
yogurmora_calan.image_from_url("http://www.calan.cl/wp-content/uploads/2015/07/bmora.png")
yogurmora_calan.save


yogurchirimoya_calan = Product.new(id: 7802995103840 ,name:"YOGUR CALÁN BOLSA CHIRIMOYA 1 Kg",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida semidescremada, azúcar, espesante (almidón modificado), leche en polvo descremada, estabilizante (gelatina), saborizante idéntico a natural, cultivos lácticos (Lactobacillus bulgaricus, Streptococcus termophilus), preservante (sorbato de potasio).Contiene: Leche y leche en polvo descremada. Puede contener trazas de: almendra, trigo, pasas, nuez.")
yogurchirimoya_calan.image_from_url("http://www.calan.cl/wp-content/uploads/2015/07/bchiri.png")
yogurchirimoya_calan.save


yogurvainilla_calan = Product.new(id: 7802955004033 ,name:"YOGUR CALÁN BOLSA VAINILLA 1 Kg",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida semidescremada, azúcar, espesante (almidón modificado), leche en polvo descremada, estabilizante (gelatina), saborizante idéntico a natural, colorantes naturales (cúrcuma y annato), cultivos lácticos (Lactobacillus bulgaricus, Streptococcus termophilus), preservante (sorbato de potasio).Contiene: Leche y leche en polvo descremada. Puede contener trazas de: almendra, trigo, pasas, nuez")
yogurvainilla_calan.image_from_url("http://www.calan.cl/wp-content/uploads/2015/07/bvai.png")
yogurvainilla_calan.save


yogurdamasco_calan = Product.new(id: 7802955004064 ,name:"YOGUR CALÁN BOLSA DAMASCO 1 Kg",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida semidescremada, azúcar, espesante (almidón modificado), leche en polvo descremada, estabilizante (gelatina), saborizante idéntico a natural, colorantes naturales (carmín y annato), cultivos lácticos (Lactobacillus bulgaricus, Streptococcus termophilus), preservante (sorbato de potasio).Contiene: Leche y leche en polvo descremada. Puede contener trazas de: almendra, trigo, pasas, nuez.")
yogurdamasco_calan.image_from_url("http://www.calan.cl/wp-content/uploads/2015/07/bdama.png")
yogurdamasco_calan.save


yogurfrutilla_calan = Product.new(id: 7802955003999 ,name:"YOGUR CALÁN BOLSA FRUTILLA 1 Kg",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida semidescremada, azúcar, espesante (almidón modificado), leche en polvo descremada, estabilizante (gelatina), saborizante idéntico a natural, colorante natural carmín, cultivos lácticos (Lactobacillus bulgaricus, Streptococcus termophilus), preservante (sorbato de potasio).Contiene: Leche y leche en polvo descremada. Puede contener trazas de: almendra, trigo, pasas, nuez.")
yogurfrutilla_calan.image_from_url("http://www.calan.cl/wp-content/uploads/2015/07/bfru.png")
yogurfrutilla_calan.save


manjarcolun = Product.new(id: 7802920777511 ,name:"Manjar Colun Pote 200g",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche fluida natural, azúcar, glucosa, espesante (agar-agar), sorbato de potasio, bicarbonato de sodio, enzima (lactasa) y saborizante idéntico a natural.")
#manjarcolun.image_from_url("www.colun.cl/resources/upload/31ec2fed8cf48cd28b4b35ebbc42ef38.png")
manjarcolun.save


kapo_frambuesa = Product.new(id: 7802820180503 ,name:"KAPO® Frambuesa 180ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, AZÚCAR, ÁCIDO MALICO, ÁCIDO CÍTRICO, CITRATO DE SODIO, SABORIZANTE NATURAL E IDÉNTICO AL NATURAL, SORBATO DE POTASIO, ALMIDON MODIFICADO, GOMA GUAR, BENZOATO DE SODIO, ROJO ALLURA AC, SUCRALOSA, VITAMINA C, VITAMINAS E, B3, B6 Y B1, SAIB, GOMA ROSIN, VITAMINA B12, DSS, AZUL BRILLANTE.")
kapo_frambuesa.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/kapo-frambuesa.jpg")
kapo_frambuesa.save


kapo_manzana = Product.new(id: 7802820180107 ,name:"KAPO® Manzana 180ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, AZÚCAR, ÁCIDO MALICO, ÁCIDO CÍTRICO, CITRATO DE SODIO, SABORIZANTE NATURAL E IDÉNTICO AL NATURAL, SORBATO DE POTASIO, ALMIDÓN MODIFICADO, GOMA GUAR, BENZOATO DE SODIO, ROJO ALLURA AC, SUCRALOSA, VITAMINA C, VITAMINA E, B3, B6 Y B1, SAIB, GOMA ROSIN, VITAMINA 12, DSS, AZUL BRILLANTE.")
kapo_manzana.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/kapo-manzana.jpg")
kapo_manzana.save


kapo_naranja = Product.new(id: 7802820180206 ,name:"KAPO® Naranja 180ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, AZÚCAR, ÁCIDO CÍTRICO, CITRATO DE SODIO, SORBATO DE POTASIO, GOMA ARÁBIGA, SAIB, SABORIZANTE NATURAL E IDÉNTICO AL NATURAL, BENZOATO DE SODIO, SUCRALOSA, VITAMINA C, VITAMINA E, B3, B6 Y B1, GOMA ESTER, TARTRAZINA, AMARILLO CREPUSCULO, DSS, VITAMINA B12.")
kapo_naranja.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/kapo-naranja.jpg")
kapo_naranja.save


kapo_pinha = Product.new(id: 7802820180305 ,name:"KAPO® Piña 180ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, AZÚCAR, ÁCIDO CÍTRICO, CITRATO DE SODIO, ÁCIDO MALICO, SABORIZANTE NATURAL E IDÉNTICO AL NATURAL, SORBATO DE POTASIO, ALMIDON MODIFICADO, BENZOATO DE SODIO, VITAMINA C, SUCRALOSA, VITAMINAS E, B3, B6 Y B1, SAIB, GOMA ESTER, TARTRAZINA, VITAMINA B12, DSS, AMARILLO CREPUSCULO")
kapo_pinha.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/kapo-pina.jpg")
kapo_pinha.save


powearederojo = Product.new(id: 7802820701012 ,name:"POWERADE® ROJO 600ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, ácido cítrico, saborizantes natural e idéntico al natural, citrato de sodio, cloruro de sodio, sorbato de potasio, citrato de potasio, cloruro de magnesio, cloruro de calcio, fosfato de potasio, vitaminas B3, B6 y B12, rojo allura AC y EDTA disódico cálcico")
powearederojo.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/powerade-frutilla-74x250.png")
powearederojo.save


poweradenaranja = Product.new(id: 7802820851052 ,name:"POWERADE®  Naranja 1L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, ácido cítrico, saborizantes naturales, citrato de sodio, cloruro de sodio, sorbato de potasio, citrato de potasio, almidón modificado, cloruro de magnesio, cloruro de calcio, fosfato de potasio, SAIB, AMARILLO CREPÚSCULO, vitaminas B3, B6 y B12, EDTA disódico cálcico, tocoferol y TARTRAZINA.")
poweradenaranja.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/powerade-naranja-72x250.png")
poweradenaranja.save


poweradegreenpunch = Product.new(id: 7802820679502 ,name:"POWERADE® Green Punch 600ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Citrato de sodio, cloruro de sodio, saborizantes natural e idéntico al natural, sorbato de potasio, citrato de potasio, almidón modificado, cloruro de magnesio, cloruro de calcio, fosfato de potasio, vitaminas B3, B6 y B12, EDTA disódico cálcico, tartrazina y azul brillante.")
poweradegreenpunch.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/powerade-punch-75x250.png")
poweradegreenpunch.save


poweradefrozenblast = Product.new(id: 7802820651157 ,name:"POWERADE® Frozen Blast 600ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, citrato de sodio, saborizantes naturales e idénticos al natural, cloruro de sodio, sorbato de potasio, citrato de potasio, almidón modificado, cloruro de magnesio, cloruro de calcio, fosfato de potasio, SAIB, vitaminas B3, B6 y B12, EDTA disódico cálcico, tocoferol y azul brillante.")
poweradefrozenblast.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/powerade-frozeen-75x250.png")
poweradefrozenblast.save


fantalata = Product.new(id: 7801610002193 ,name:"FANTA® Naranja Lata 350 cc",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, azúcar, acido cítrico, almidón modificado, benzoato de sodio, saborizantes naturales e idénticos al natural, SAIB, AMARILLO CREPUSCULO, rojo allura AC, DSS y BHA.")
fantalata.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Fanta-Naranja_-Pet-OW-500-cc2-72x250.jpg")
fantalata.save


spritelata = Product.new(id: 7801610005194 ,name:"SPRITE® Lata 350 cc",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, azúcar, ácido cítrico, saborizantes naturales, citrato de sodio y benzoato de sodio.")
spritelata.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Sprite-79x250.jpg")
spritelata.save


cocacolalightlata = Product.new(id: 7801610022122 ,name:"COCA-COLA LIGHT® Lata 350 cc",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, color caramelo, ácido fosfórico, saborizantes naturales, Aspartamo, Benzoato de Sodio, Acesulfamo de Potasio, cafeína y ácido cítrico. Fenilcetonúricos: contiene fenilalanina.")
cocacolalightlata.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/botella1-78x250.jpg")
cocacolalightlata.save


cocacolazerolata = Product.new(id: 7801610350355 ,name:"COCA-COLA ZERO® Lata 350 cc",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, color caramelo, ácido fosfórico, aspartamo, saborizantes naturales, benzoato de sodio, acesulfamo de potasio, citrato de sodio, cafeína, ácido cítrico. Fenilcetonúricos: contiene fenilalanina.")
cocacolazerolata.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/botella2-78x250.jpg")
cocacolazerolata.save


cocacolalife = Product.new(id: 7801610720035 ,name:"COCA-COLA LIFE® 350ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua carbonatada, azúcar, color caramelo, ácido fosfórico, saborizantes naturales, Estevia (glicósidos de esteviol), Benzoato de Sodio, cafeína.")
cocacolalife.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/botella4-78x250.jpg")
cocacolalife.save


aquariuspera = Product.new(id: 7801610402061 ,name:"AQUARIUS® Pera 1,5L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, jugo de pera (10% m/m sólidos solubles), ácido cítrico, polifosfato de sodio, saborizante idéntico natural, sorbato de potasio, citrato de sodio, benzoato de sodio, EDTA disódico cálcico, TARTRAZINA.")
aquariuspera.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Aquarius-Pera-150x506-72x250.jpg")
aquariuspera.save


andinanectar_durazno = Product.new(id: 7802820500097 ,name:"ANDINA® Durazno Nectar 1L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, pulpa de durazno, carboximetilcelulosa, ácido cítrico, ácido ascórbico, saborizante idéntico natural, sorbato de potasio, pectina, EDTA disódico cálcico, dimetilpolisiloxano.")
andinanectar_durazno.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/andina-durazno-89x250.png")
andinanectar_durazno.save


andinanectar_damasco = Product.new(id: 7802820000085 ,name:"ANDINA® Damasco Nectar 1L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, pulpa de damasco, ácido cítrico, carboximetilcelulosa, saborizante idéntico natural, sorbato de potasio, ácido ascórbico, pectina, EDTA disódico cálcico, dimetilpolisiloxano.")
andinanectar_damasco.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Andina-BA-300-Damasco-150px-88x250.jpg")
andinanectar_damasco.save


andinapinha_nectar = Product.new(id: 7802820700275 ,name:"ANDINA® Piña Nectar 1L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Agua, azúcar, pulpa de damasco, ácido cítrico, carboximetilcelulosa, saborizante idéntico natural, sorbato de potasio, ácido ascórbico, pectina, EDTA disódico cálcico, dimetilpolisiloxano.")
#andinapinha_nectar.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/Andina-BA-300-Piña-150px1-89x250.jpg")
andinapinha_nectar.save


andinanectarlight_durazno = Product.new(id: 7802820500219 ,name:"ANDINA® Durazno Light Nectar 300ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, PULPA CONCENTRADA DE DURAZNO, CMC SÓDICA, ÁCIDO ASCORBICO, ÁCIDO CÍTRICO, SABORIZANTE IDÉNTICO NATURAL, GOMA XANTHAN, SUCRALOSA, SORBATO DE POTASIO, CITRATO DE SODIO, EDTA DISODICO CALCICO, DIMETILPOLISILOXANO, BETACAROTENO")
andinanectarlight_durazno.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/durazno-light-88x250.jpg")
andinanectarlight_durazno.save


andinanectarlight_pinha = Product.new(id: 7802820655667 ,name:"ANDINA® Piña Light Nectar 1L",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"AGUA, JUGO CONCENTRADO DE PIÑA, CMC SÓDICA, ÁCIDO ASCÓRBICO, GOMA XANTHAN, ÁCIDO CÍTRICO, SUCRALOSA, SABORIZANTE IDÉNTICO NATURAL Y ARTIFICIA, SORBATO DE POTASIO, CITRATO DE SODIO, COLOR CARAMELO, EDTA DISÓDICO CÁLCICO, DIMETILPOLISILOXANO.")
andinanectarlight_pinha.image_from_url("http://www.cocacoladechile.cl/wp-content/uploads/sites/15/pina-light-88x250.jpg")
andinanectarlight_pinha.save


ramitasquesoG = Product.new(id: 7802000002793 ,name:"Ramitas Queso bolsa grande",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Harina, aceite vegetal alto oleico, queso en polvo, aceite vegetal, sal, sólidos de leche, azúcar, emulsionante (estearil lactilato de sodio), antioxidante (TBHQ).")
ramitasquesoG.image_from_url("http://ep.yimg.com/ca/I/yhst-62086439978846_2266_14837706")
ramitasquesoG.save


lechetrencito = Product.new(id: 7802950006339 ,name:"Leche Nestle Trencito 200ml",image_file_name: nil, image_content_type: nil,image_file_size: nil,image_updated_at: nil,likes: nil,denounced: nil,ingredients:"Leche parcialmente descremada, agua, azucar, cacao, maltodextrina, espesantes, (celulosa microcristalina, carragenina, goma de celulosa), edulcolorante, glucosa, saborizantes, puede contener soya y gluten.")
lechetrencito.image_from_url("http://www.jumbo.cl/FO_IMGS/gr/302831-ST.jpg")
lechetrencito.save

listaProductos = [triton, cocacola, golazo, ramitasQueso, aquariosManzana, lecheColun, nectar_manzana,cerealbar_choco,spaguetti_vivo,yogurmora_calan,yogurchirimoya_calan,yogurvainilla_calan,yogurdamasco_calan,yogurfrutilla_calan,manjarcolun,kapo_frambuesa,kapo_manzana,kapo_naranja,kapo_pinha,powearederojo,poweradenaranja,poweradegreenpunch,poweradefrozenblast,fantalata,spritelata,cocacolalightlata,cocacolazerolata,cocacolalife,aquariuspera,andinanectar_durazno,andinanectar_damasco,andinapinha_nectar,andinanectarlight_durazno,andinanectarlight_pinha,ramitasquesoG, lechetrencito]

listaProductos.each do |producto|
	#busqueda de intolerancia en la descripcion
	#Usar arreglo con las intolerancias (listaIntolerancias)?????
	Intolerance.all.each do |intolerancia|
		#se recorre cada key compoent desde las intolerancias
		intolerancia.key_components.each do |component|
			#si posee un key_component en los ingredientes, se agrega la intolerancia al producto
			producto.ingredients.split(" ").each do |palabra_ingrediente|
				if palabra_ingrediente.downcase.similar(component.downcase) > 80
					p component+" hace match con "+palabra_ingrediente
					producto.intolerances << intolerancia if !producto.intolerances.include?(intolerancia)
				end
			end
		end
	end
end

comentarioOK = Comment.create(title: "Me gusta", description: "buen producto, me ha servido mucho y nunca me ha echo mal", likes: 16, dislikes: 1, user_id: usuarioComun.id, product_id: triton.id)
comentarioNO = Comment.create(title: "Lo odio", description: "Mal, mal, mal, todo mal, no me gusta ese sabor! esto esta super mal, si no me gusta a mi a nadie le tiene que gustar!! >.<", likes: 1, dislikes: 14, user_id: usuarioComun.id, product_id: triton.id)


# Notification.create(from_type: "comment", from_id: comentarioNO.id)
# Notification.create(from_type: "comment", from_id: comentarioOK.id)
# Notification.create(from_type: "product", from_id: triton.id)
# Notification.create(from_type: "contact", from_id: usuarioComun.id, message: "NoSoyJorge:Hola! quisiera saber cuando sera el lanzamiento de esta hermosa aplicacion")