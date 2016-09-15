
User.create(email: "ajorjao13@gmail.com", password: "asdasd123", admin: "true", username: "Administrador Jorge")
usuarioComun = User.create(email: "ajorjao123@gmail.com", password: "asdasd123", admin: "false", username: "Jorjo")

#no mover el orden de las intolerancias
lactosa = Intolerance.create(name: "lactosa", minor_symptom: "", medium_symptom: "Náuseas
	Dolor abdominal
	Espasmos
	Hinchazón y distensión abdominal
	Gases abdominales y flatulencias
	Diarreas ácidas
	Heces pastosas y flotantes
	Defecación explosiva
	Vómitos
	Enrojecimiento periana", major_symptom: "", key_components: ["lactosa","lactose","leche","milk"])

gluten = Intolerance.create(name: "gluten", minor_symptom: "", medium_symptom: "Diarrea crónica
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
	Fracturas espontáneas", major_symptom: "", key_components: ["trigo", "centeno", "cebada", "escanda", "espelta", "triticale", "farro", "kamut", "espelta verde", "bulgur", "avena"])

mani = Intolerance.create(name: "mani", minor_symptom: "", medium_symptom: "Dolor estomacal
	Goteo nasal
	Picazón de ojos
	Ronchas (Urticaria) u hormigueo en los labios o la lengua", major_symptom: "", key_components: ["mani","cacahuate","peanut","frutos secos"])

nueces = Intolerance.create(name: "nueces", minor_symptom: "", medium_symptom: "Picazón o hinchazón de la boca, la lengua o los labios
	Reacciones en la piel (Eccema, urticaria, hinchazón y enrojecimiento de la cara o las extremidades)
	Los síntomas gastrointestinales (Dolor abdominal, náuseas, vómitos, diarrea)
	Los síntomas respiratorios (Secreción o congestión nasal, tos, estornudos, respiración sibilante, dificultad para respirar)
	Los síntomas cardiovasculares (Caída en la presión arterial, mareos, desmayos)", major_symptom: "", key_components: ["nuez","nut","nueces","frutos secos"])

apio = Intolerance.create(name: "apio", minor_symptom: "", medium_symptom: "Vómitos
	Diarrea
	Erupciones en la piel
	Inflamación de las vías respiratorias
	Disminución de la presión arterial
	Reacción anafiláctica", major_symptom: "", key_components: ["apio","apium","graviolens","celery"])

mostaza = Intolerance.create(name: "mostaza", minor_symptom: "", medium_symptom: "Urticaria
	Eccema
	Asma bronquial
	Dolor gástrico
	Shock anafiláctico", major_symptom: "", key_components: ["mostaza","mustard"])

huevo = Intolerance.create(name: "huevo", minor_symptom: "", medium_symptom: "Reacciones cutáneas
		Síntomas gastrointestinales agudos y respiratorios
		Reacción generalizada de anafilaxia (Junto con hipotensión, colapso vascular y disrritmias cardiacas)", major_symptom: "", key_components: ["egg","huevo", "lecitina", "lisozima", "albúmina", "coagulante", "emulsificante", "gloubina", "livetina", "ovoalbúmina", "ovomucina", "ovomucoide", "otransferrina", "ovovitelina", "vitelina", "e-16b,luteína", "pigmento amarillo"])

sesamo = Intolerance.create(name: "sesamo", minor_symptom: "", medium_symptom: "Dermatitis de contacto 
		Urticaria
		Rinitis alérgica
		Asma
		Dermatitis atópica
		Anafilaxia", major_symptom: "", key_components: ["sésamo","ajonjolí","sesame"])

pescado = Intolerance.create(name: "pescado", minor_symptom: "", medium_symptom: "Hinchazón de los labios
	Prurito o picor en la cavidad bucal
	Dificultad para deglutir
	Urticaria
	Rinitis
	Dolor abdominal
	Diarrea
	Ronchas graves
	Dificultad respiratoria y asma
	Náuseas y vómitos", major_symptom: "", key_components: ["fish","pescado","[ESPECIES DE PESCADO???]"])

crustaceo = Intolerance.create(name: "crustaceos", minor_symptom: "", medium_symptom: "Urticaria aguda
	Asma
	Rinitis
	Anafilaxia
	Síndrome de alergia oral", major_symptom: "", key_components: ["crustáceos","crustacean","[ESPECIES DE CRUSTACEOS???]"])

moluscos = Intolerance.create(name: "moluscos", minor_symptom: "", medium_symptom: "Urticaria aguda			
	Asma
	Anafilaxia
	Síndrome de alergia oral", major_symptom: "", key_components: ["moluscos","molluscs","[ESPECIES DE MOLUSCOS????]"])

soya = Intolerance.create(name: "soya", minor_symptom: "", medium_symptom: "Hinchazón en labios, cara, lengua, garganta y otras partes del cuerpo
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
		Anafilaxia: constricción de las vías respiratorias, incluyendo la inflamación de garganta", major_symptom: "", key_components: ["soya", "mono-diglicerido", "soya", "soja", "yuba", "tsf" ,"harina de soya texturizada", "tsp" ,"proteína de soya texturizada","proteina de soya texturizada","tvp", "proteína vegetal texturizada", "lecitina", "msg", "lutamato monosodico"])

sulfitos = Intolerance.create(name: "sulfitos", minor_symptom: "", medium_symptom: "Estornudos
	Secreción nasal (rinorrea)
	Prurito (picor)
	Erupción (aparecen granos, como urticaria)
	Dolor abdominal o posiblemente asma", major_symptom: "", key_components: ["sulfitos","sulfites","Dióxido de azufre","E220","Sulfito sódico","E221","Sulfito ácido de sodio","E222","Metabisulfito sódico","Disulfito sódico","E223", "Metabisulfito potásico","Disulfito potásico","E224",  "Sulfito cálcico", "E226","Sulfito ácido de calcio","Bisulfito cálcico", "E227", "Sulfito ácido de potasio" ,"Bisulfito potásico" ,"E228"])

legumbres = Intolerance.create(name: "legumbres", minor_symptom: "", medium_symptom: "Síndrome de alergia oral
	Urticaria
	Angioedema
	Rinitis
	Crisis asmáticas
	Anafilaxia", major_symptom: "", key_components: ["legumbre","legume","lupinus albus","altramuz","altramuces","lupins","lupino"])

#no se si esto funciona!!!
listaIntolerancias = ["legumbres", "sulfitos","soya"," moluscos" ,"crustaceo", "pescado", "sesamo", "huevo" ,"mostaza", "apio", "nueces" ,"mani" ,"gluten", "lactosa"]
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

listaProductos = [triton, cocacola, golazo, ramitasQueso, aquariosManzana, lecheColun]

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

comentarioOK = Comment.create(title: "Me gusta", description: "buen producto, me ha servido mucho", likes: 16, dislikes: 1)
comentarioNO = Comment.create(title: "Lo odio", description: "tu mal, yo mal, el mal, ellos mal, todo mal", likes: 1, dislikes: 16)


# ap Notification.create(from_type: "comment", from_id: 1)
Notification.create(from_type: "comment", from_id: comentarioNO.id)
Notification.create(from_type: "comment", from_id: comentarioOK.id)
Notification.create(from_type: "product", from_id: triton.id)
Notification.create(from_type: "contact", from_id: usuarioComun.id, message: "NoSoyJorge:Hola! quisiera saber cuando sera el lanzamiento de esta hermosa aplicacion")