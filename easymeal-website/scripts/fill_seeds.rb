# -*- encoding : utf-8 -*-
#!/usr/bin/env rvm 2.0.0 do ruby
# encoding: utf-8

require "csv"

categories = []
aliments = []

# Parse CSV file
filename = File.expand_path('CIQUAL2013-Donnees.csv')
counter = 0
File.open(filename, "r:ISO-8859-1") do |file|
  CSV.parse(file.read.encode("UTF-8"), col_sep: ";") do |row| 
    categories << {"ident" => row[0], "name" => row[1]} if !categories.include?({"ident" => row[0], "name" => row[1]}) && counter != 0
    aliments << {
                "name" => row[3],
                "category_ref" => row[0],
                "calories" => row[20].to_f,
                "sugar" => row[18].to_f,
                "protein" => row[15].to_f,
                "cholesterol" => row[61].to_f,
                "fiber" => row[25].to_f,
                "iron" => row[10].to_f,
                "magnesium" => row[5].to_f,
                "vitaminB1" => row[52].to_f,
                "vitaminB2" => row[53].to_f,
                "vitaminB3" => row[54].to_f,
                "vitaminB5" => row[55].to_f,
                "vitaminB6" => row[56].to_f,
                "vitaminB9" => row[58].to_f,
                "vitaminB12" => row[57].to_f,
                "vitaminC" => row[51].to_f,
                "vitaminD" => row[47].to_f,
                "vitaminE" => row[48].to_f,
                "quantity" => "100.0".to_f,
                "isQuantifiable" => "true",
                "averagePrice" => "0.0".to_f
                } if counter != 0
    counter += 1
  end
end

categories << {"ident" => 35, "name" => "Plat préparé, industriel"}

aliments << {
            "name" => "Cordon bleu de volaille",
            "category_ref" => 35,
            "calories" => 230,
            "sugar" => 1.15,
            "protein" => 14.7,
            "cholesterol" => 0,
            "fiber" => 0.6,
            "iron" => 0.656,
            "magnesium" => 32.1,
            "vitaminB1" => 0.13,
            "vitaminB2" => 0.12,
            "vitaminB3" => 4.8,
            "vitaminB5" => 0.6,
            "vitaminB6" => 0.28,
            "vitaminB9" => 0,
            "vitaminB12" => 0,
            "vitaminC" => 0,
            "vitaminD" => 0,
            "vitaminE" => 2.4,
            "quantity" => 100.0,
            "isQuantifiable" => "false",
            "averagePrice" => 0.75
            }

# puts categories and aliments in seeds file
File.open("../db/seeds.rb", 'w') do |file|
  categories.each do |category|
    # puts category.inspect
    file.write("Category.create(ident: '" + category["ident"].to_s + "', name: \"" + category["name"] + "\")\n")
  end
  
  file.write("\n")
  
  counter = 0
  aliments.each do |aliment|
    # puts category.inspect
    file.write("Aliment.create(name: \"" + aliment["name"] +
                "\", calories: " + aliment["calories"].to_s +
                ", sugar: " + aliment["sugar"].to_s +
                ", protein: " + aliment["protein"].to_s +
                ", cholesterol: " + aliment["cholesterol"].to_s +
                ", fiber: " + aliment["fiber"].to_s +
                ", iron: " + aliment["iron"].to_s +
                ", magnesium: " + aliment["magnesium"].to_s +
                ", vitaminB1: " + aliment["vitaminB1"].to_s +
                ", vitaminB2: " + aliment["vitaminB2"].to_s +
                ", vitaminB3: " + aliment["vitaminB3"].to_s +
                ", vitaminB5: " + aliment["vitaminB5"].to_s +
                ", vitaminB6: " + aliment["vitaminB6"].to_s +
                ", vitaminB9: " + aliment["vitaminB9"].to_s +
                ", vitaminB12: " + aliment["vitaminB12"].to_s +
                ", vitaminC: " + aliment["vitaminC"].to_s +
                ", vitaminD: " + aliment["vitaminD"].to_s +
                ", vitaminE: " + aliment["vitaminE"].to_s +
                ", quantity: " + aliment["quantity"].to_s +
                ", isQuantifiable: " + aliment["isQuantifiable"].to_s +
                ", averagePrice: " + aliment["averagePrice"].to_s +
                ", categories: Category.where(ident: '" + aliment["category_ref"].to_s + "')" +
                ", ident: " + counter.to_s +
                ")\n")
    counter += 1
  end
  file.write("\n")
  file.write('Recipe.create(name: "Cordon bleu et petit poids", ' + 
  'aliments_quantity: [ AlimentsQuantity.create(aliment: Aliment.find_by(name: "Petit pois, appertisé, égoutté"), quantity: 100), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Cordon bleu de volaille"), quantity: 1)],' +
  'text: "<ol>Dans une poêle, faire dorer les cordons bleus 5 minutes de chaque côté sans ajout de matière grasse.</ol>' +
  '<ol>Ouvrez la boîte de petits pois et faites chauffer dans une casserole le temps indiqué.</ol>' +
  '<ol>Égouttez les petits pois et servez.</ol>", time: 10, price: 3, difficulty: 1, photo: File.open("app/assets/images/recipes/petits_poids_cordon.png"))
Recipe.create(name: "Crumble aux pommes", ' +
  'aliments_quantity: [ AlimentsQuantity.create(aliment: Aliment.find_by(name: "Pomme, fraîche, pulpe et peau"), quantity: 1200), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Sucre roux"), quantity: 150), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Farine de blé tendre ou froment T110"), quantity: 150), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Beurre doux"), quantity: 125), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Cannelle"), quantity: 2)],' +
  'text: "<ol>Préchauffer le four à thermostat 7 (210°C).</ol>' +
  '<ol>Peler, évider et découper les pommes en cubes grossiers, les répartir dans un plat allant au four, verser dessus le jus du citron et la cannelle.</ol>' +
  '<ol>Dans un saladier, mélanger la farine et la cassonade. Puis ajouter le beurre en petits cubes et mélanger à la main de façon à former une pâte grumeleuse.</ol>' +
  '<ol>Émietter cette pâte au dessus des pommes de façon à les recouvrir. Mettre au four une bonne 1/2 heure.</ol>", time: 100, price: 3, difficulty: 1, photo: File.open("app/assets/images/recipes/crumble.jpg"))
Recipe.create(name: "Cake salé au jambon et aux olives", ' +
  'aliments_quantity: [ AlimentsQuantity.create(aliment: Aliment.find_by(name: "Farine de blé tendre ou froment T55 (pour pains)"), quantity: 150), ' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Jambon cuit"), quantity: 200),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Olive verte, entière ou dénoyautée, en saumure"), quantity: 150),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Emmental râpé"), quantity: 75),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Emmental râpé"), quantity: 75),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Oeuf, cru"), quantity: 75),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Lait demi-écrémé, UHT"), quantity: 10),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Levure alimentaire"), quantity: 10),' +
  'AlimentsQuantity.create(aliment: Aliment.find_by(name: "Huile d\'olive vierge"), quantity: 1.5)],' +
  'text: "<ol>Couper les olives en rondelles. Couper le jambon en morceaux. </ol>' +
  '<ol>Verser les oeufs dans la farine et mélanger. Ajouter le lait et l\'huile puis mélanger. Ajouter le jambon, les olives et le gruyère puis mélanger. Ajouter la levure et, pour ne pas changer, mélanger.</ol>' +
  '<ol>Mettre le tous dans un plat à cake au préalable beurré et placer dans un four chaud à thermostat 6 (180°C) pendant 45 min.</ol>", time: 65, price: 4, difficulty: 1, photo: File.open("app/assets/images/recipes/cake_jambon_olives.jpg"))
Recipe.create(name: "Cordon bleu et haricots", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Haricot vert, surgelé, cuit"), quantity: 100), AlimentsQuantity.create(aliment: alim2 = Aliment.find_by(name: "Cordon bleu de volaille"), quantity: 1)],text: "<ol><li>Dans une poêle, faire dorer les cordons bleus 5 minutes de chaque côté sans ajout de matière grasse.</li><li>Ouvrez le sachet d\'haricots verts et faites chauffer dans une casserole le temps indiqué.</li><li>Servez les haricots verts accompagnés des cordon bleus.</li></ol>", time: 10, price: 1, difficulty: 1, calories: alim1.calories + alim2.calories, photo: File.open("app/assets/images/recipes/cordon_haricot.jpg"))
Recipe.create(name: "Purée de haricots verts", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Haricot vert, surgelé, cuit"), quantity: 200), AlimentsQuantity.create(aliment: alim2 = Aliment.find_by(name: "Pomme de terre, sans peau, cuite au four"), quantity: 1), AlimentsQuantity.create(aliment: alim3 = Aliment.find_by(name: "Crème fraîche >= 30% MG, épaisse, rayon frais"), quantity: 20), AlimentsQuantity.create(aliment: alim4 = Aliment.find_by(name: "Ail frais"), quantity: 2)], text: "<ol><li> Equeuter et laver les haricots.</li><li>Mettre les haricots et les pommes de terre en autocuiseur et cuire 10 min à la vapeur.</li><li>Mixer le tout avec les gousses d\'ail.</li><li>Y ajouter la crème fraîche.</li></li>Présenter la purée dans un joli plat ou en ramequin individuel avec une pointe de persil.</li></ol>", time: 10, price: 1, difficulty: 1, calories: alim1.calories + alim2.calories + alim3.calories + alim4.calories, photo: File.open("app/assets/images/recipes/puree_haricot.jpg"))
Recipe.create(name: "Oeuf à la coque", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Oeuf dur"), quantity: 1)],text: "<ol><li>Cuire 3 minutes après ébullition.</li><li>Egoutter.</li><li>Mettre dans le coquetier, découper le dessus de l\'oeuf délicatement.</li><li>Servir.</li></ol>", time: 3, price: 1, difficulty: 1, calories: alim1.calories, photo: File.open("app/assets/images/recipes/oeuf_coque.jpg"))
Recipe.create(name: "Tarte à la tomate", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Pâte brisée, cuite"), quantity: 1), AlimentsQuantity.create(aliment: alim2 = Aliment.find_by(name: "Tomate, crue"), quantity: 6), AlimentsQuantity.create(aliment: alim3 = Aliment.find_by(name: "Moutarde"), quantity: 1), AlimentsQuantity.create(aliment: alim4 = Aliment.find_by(name: "Huile d\'olive vierge"), quantity: 1), AlimentsQuantity.create(aliment: alim5 = Aliment.find_by(name: "Herbes aromatiques fraîches (aliment moyen)"), quantity: 1)], text: "<ol><li>Etaler la pâte dans le moule et piquer le fond avec une fourchette.</li><li>Etaler la moutarde.</li><li>Couper les tomates en rondelles ou en quartiers et les faire dégorger avec du sel.</li><li>Placer les tomates en rosace puis arroser le tout de la cuillère d\'huile d\'olive.</li><li>Saupoudrer le tout avec des herbes aromatiques.</li><li>Faire cuire 25 min à 180°C.</li></ol>", time: 25, price: 1, difficulty: 1, calories: alim1.calories + alim2.calories + alim3.calories + alim4.calories + alim5.calories, photo: File.open("app/assets/images/recipes/tarte_tomate.jpg"))
Recipe.create(name: "Melon campagnard", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Melon, frais, pulpe"), quantity: 10), AlimentsQuantity.create(aliment: alim2 = Aliment.find_by(name: "Jambon cru"), quantity: 1),  AlimentsQuantity.create(aliment: alim3 = Aliment.find_by(name: "Tomate, crue"), quantity: 1)],text: "<ol><li>Découper 5 fines tranches de melon.</li><li>Découper 5 fines tranches dans le jambon et prédécouper la chair en cube</li><li>Disposer dans l\'assiette.</li><li>Ajouter le jambon cru découper en lamelles.</li><li>Déposer la tomate coupée en quartiers. </li></ol>", time: 10, price: 1, difficulty: 1, calories: alim1.calories + alim2.calories + alim3.calories, photo: File.open("app/assets/images/recipes/melon_campagnard.jpg"))
Recipe.create(name: "Oeuf au plat poivron", aliments_quantity: [ AlimentsQuantity.create(aliment: alim1 = Aliment.find_by(name: "Oeuf dur"), quantity: 1), AlimentsQuantity.create(aliment: alim2 = Aliment.find_by(name: "Poivron, vert, jaune ou rouge, cuit"), quantity: 1),  AlimentsQuantity.create(aliment: alim3 = Aliment.find_by(name: "Sel blanc alimentaire, iodé, non fluoré (marin, ignigène ou gemme)"), quantity: 1),  AlimentsQuantity.create(aliment: alim4 = Aliment.find_by(name: "Poivre noir, moulu"), quantity: 1),  AlimentsQuantity.create(aliment: alim5 = Aliment.find_by(name: "Huile d\'olive vierge"), quantity: 1),  AlimentsQuantity.create(aliment: alim6 = Aliment.find_by(name: "Beurre doux"), quantity: 1)],text: "<ol><li>Laver le poivron, et couper des lamelles de 1 cm environ, bien l\'évider.</li><li>Faire chauffer un peu d\'huile et de beurre  dans une poêle faire revenir les poivrons, ajouter l\'oeufs à l\'interieur, saler poivrer.</li><li>Servir.</li></ol>", time: 15, price: 1, difficulty: 1, calories: alim1.calories + alim2.calories + alim3.calories + alim4.calories + alim5.calories + alim6.calories, photo: File.open("app/assets/images/recipes/oeuf_poivron.jpg"))

DietType.create(name: "Stabilisation")
DietType.create(name: "Hypocalorique")
DietType.create(name: "Hypercalorique")

Disease.create(name: "Maladie de Crohn")
Disease.create(name: "Diabète")
Disease.create(name: "Sigmoïdite")
Disease.create(name: "Maladie coeliaque")
Disease.create(name: "Colite ulcéreuse")
Disease.create(name: "Syndrome de l\'intestion irritable")
Disease.create(name: "Aérogastrie")
Disease.create(name: "Aéroiléie")
Disease.create(name: "Aérocolie")
Disease.create(name: "Reflux gastro-oesophagien")

Disease.find(1).forbid << Aliment.where(:ident => [124,125,126, 128, 347, 1270, 703, 722, 1421, 75, 305, 1040, 1043, 1287, 1293, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551,552, 553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605, 606,607,608,609, 610,611,612,613,614,615, 616, 617, 618, 619,620, 621,622,623,624,625])
Disease.find(1).big_quantity << Aliment.where(:ident => [42,43,44, 45, 46, 491, 492, 220,221, 1188, 404, 972, 973, 974])
Disease.find(2).big_quantity << Aliment.where(:ident => [71, 997,998,999, 1264, 522, 513,1251, 1250, 1003, 1006, 1239,1240,1241, 1242,1243,1244,1245,1246, 1042, 512, 261, 1188, 1187,1186, 1185, 1184, 1183, 1181, 943,944,945, 946, 894,895,896,897,898,899, 791, 792, 793])
Disease.find(2).forbid << Aliment.where(:ident => [124,125,126, 128, 347, 1270, 703, 722, 1421, 75, 305, 1040, 1043, 1287, 1293, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551,552, 553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605, 606,607,608,609, 610,611,612,613,614,615, 616, 617, 618, 619,620, 621,622,623,624,625])
Disease.find(3).big_quantity << Aliment.where(:ident => [791, 792, 793, 1181, 1183, 1184,1185,1186,1187,1188, 1006, 1003, 1250, 1251, 261, 512, 1042, 1240, 1241, 1242, 1243, 1244, 1245, 1246])
Disease.find(3).forbid << Aliment.where(:ident => [910, 911, 759, 883, 929, 930, 868, 869, 870, 871, 872, 1248])
Disease.find(4).big_quantity << Aliment.where(:ident => [906, 907, 1181, 1183, 1184, 1185, 1185, 1186, 1187, 1188, 261, 512, 1042, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246])
Disease.find(4).forbid << Aliment.where(:ident => [521, 993, 994, 1000, 1255, 1031, 1032, 1033, 1034])
Disease.find(5).big_quantity << Aliment.where(:ident => [42,43,44, 45, 46, 491, 492, 220,221, 1188, 404, 972, 973, 974])
Disease.find(5).forbid << Aliment.where(:ident => [124,125,126, 128, 347, 1270, 703, 722, 1421, 75, 305, 1040, 1043, 1287, 1293, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551,552, 553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605, 606,607,608,609, 610,611,612,613,614,615, 616, 617, 618, 619,620, 621,622,623,624,625])
Disease.find(6).big_quantity << Aliment.where(:ident => [852,853, 1174, 860, 861, 862, 1188, 42,43,44,45, 46, 491, 492])
Disease.find(6).forbid << Aliment.where(:ident => [124,125,126, 128, 347, 1270, 703, 722, 1421, 75, 305, 1040, 1043, 1287, 1293, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551,552, 553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605, 606,607,608,609, 610,611,612,613,614,615, 616, 617, 618, 619,620, 621,622,623,624,625])
Disease.find(7).big_quantity << Aliment.where(:ident => [892,893, 768, 855,680, 681, 689, 1239,1240,1241, 1242,1243,1244,1245,1246, 1042, 512, 261, 404, 972,973,974])
Disease.find(7).forbid << Aliment.where(:ident => [947, 948, 943, 944, 850, 851, 906, 907, 688, 1251, 1250, 1003, 1006])
Disease.find(8).big_quantity << Aliment.where(:ident => [892,893, 768, 855,680, 681, 689, 1239,1240,1241, 1242,1243,1244,1245,1246, 1042, 512, 261, 404, 972,973,974])
Disease.find(8).forbid << Aliment.where(:ident => [947, 948, 943, 944, 850, 851, 906, 907, 688, 1251, 1250, 1003, 1006])
Disease.find(9).big_quantity << Aliment.where(:ident => [892,893, 768, 855,680, 681, 689, 1239,1240,1241, 1242,1243,1244,1245,1246, 1042, 512, 261, 404, 972,973,974])
Disease.find(9).forbid << Aliment.where(:ident => [947, 948, 943, 944, 850, 851, 906, 907, 688, 1251, 1250, 1003, 1006])
Disease.find(10).big_quantity << Aliment.where(:ident => [862, 861, 660, 684, 631, 768, 1251, 1250, 1003, 1006, 943, 944, 945, 946, 894, 895, 896, 897, 898, 899])
Disease.find(10).forbid << Aliment.where(:ident => [1294, 1324, 759, 911, 910])')
end
