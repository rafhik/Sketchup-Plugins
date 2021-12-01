#Add IFC Quantities PSet to selection


require 'sketchup.rb'
#require 'AddIfcQuantities_toSelection.rb'

module AddQuantities
    def self.addq
        #SKETCHUP_CONSOLE.show
        prompts = ["Type?", "SubType?", "Description?"]
        defaults = ["IfcElement", "IfcElementType", ""]
        input = UI.inputbox(prompts, defaults, "Data entry")

        

        counter = 1
        
        for instance in Sketchup.active_model.selection do
                    
            instance.name = input[1] #repetible debiera ser el tipo y el valor de la definition siguiente
            instance.definition.name = "#{input[1]}_#{counter.to_s}" #unico
            
                b = instance.name
                bbb = instance.definition.bounds
                tttt = instance.transformation
                x = ((((bbb.max.x-bbb.min.x) * tttt.xscale)/39.37).round(2)).to_f
                y = ((((bbb.max.y-bbb.min.y) * tttt.yscale)/39.37).round(2)).to_f
                z = ((((bbb.max.z-bbb.min.z) * tttt.zscale)/39.37).round(2)).to_f
                           
                if instance.manifold?
                    a = (instance.volume/61024).round(2)
                    v = a
                    s = (a/z).round(2)
                else
                    a = "no calculable"
                    v = (x*y*z).round(2)
                    s = (x*y).round(2)
                end


            ifcDict = instance.definition.attribute_dictionary("IFC 2x3")
            ifcQuantities = ifcDict.attribute_dictionary("PsetQuantityTakeOff", true)
            ifcQuantitiesNetVolume = ifcQuantities.attribute_dictionary("NetVolume", true)
            
            ifcQuantitiesNetVolume.set_attribute "IfcQuantityVolume", "value", a.to_s
            ifcQuantitiesNetVolume.set_attribute "IfcQuantityVolume", "is_hidden", false
            ifcQuantitiesNetVolume.set_attribute "IfcQuantityVolume", "attribute_type", Float
                
            ifcQuantitiesGrossVolume = ifcQuantities.attribute_dictionary("GrossVolume", true)

            ifcQuantitiesGrossVolume.set_attribute "IfcQuantityVolume", "value", v.to_s
            ifcQuantitiesGrossVolume.set_attribute "IfcQuantityVolume", "is_hidden", false
            ifcQuantitiesGrossVolume.set_attribute "IfcQuantityVolume", "attribute_type", Float

            ifcQuantitiesGrossFootprintArea = ifcQuantities.attribute_dictionary("GrossFootprintArea", true)

            ifcQuantitiesGrossFootprintArea.set_attribute "IfcQuantityArea", "value", s.to_s
            ifcQuantitiesGrossFootprintArea.set_attribute "IfcQuantityArea", "is_hidden", false
            ifcQuantitiesGrossFootprintArea.set_attribute "IfcQuantityArea", "attribute_type", Float

            ifcQuantitiesNominalLength = ifcQuantities.attribute_dictionary("NominalLength", true)

            ifcQuantitiesNominalLength.set_attribute "IfcQuantityLength", "value", x.to_s
            ifcQuantitiesNominalLength.set_attribute "IfcQuantityLength", "is_hidden", false
            ifcQuantitiesNominalLength.set_attribute "IfcQuantityLength", "attribute_type", Float

            ifcQuantitiesNominalWidth = ifcQuantities.attribute_dictionary("NominalWidth", true)

            ifcQuantitiesNominalWidth.set_attribute "IfcQuantityLength", "value", y.to_s
            ifcQuantitiesNominalWidth.set_attribute "IfcQuantityLength", "is_hidden", false
            ifcQuantitiesNominalWidth.set_attribute "IfcQuantityLength", "attribute_type", Float

            ifcQuantitiesNominalHeight = ifcQuantities.attribute_dictionary("NominalHeight", true)

            ifcQuantitiesNominalHeight.set_attribute "IfcQuantityLength", "value", z.to_s
            ifcQuantitiesNominalHeight.set_attribute "IfcQuantityLength", "is_hidden", false
            ifcQuantitiesNominalHeight.set_attribute "IfcQuantityLength", "attribute_type", Float    

            ifcQuantities.set_attribute "Units", "value", "volume (m3) - area (m2) - length (m)"
            ifcQuantities.set_attribute "Units", "is_hidden", false
            ifcQuantities.set_attribute "Units", "attribute_type", String

            for dic in ifcDict.attribute_dictionaries do
                puts dic.set_attribute "IfcText", "value", input[2].to_s if dic.name == "Description"
                puts dic.set_attribute "IfcLabel", "value", "#{input[1]}_#{counter.to_s}" if dic.name == "Name"
                puts dic.set_attribute "IfcLabel", "value", "#{input[0]}" if dic.name == "ObjectType"
                puts dic.set_attribute "IfcIdentifier", "value", "#{counter.to_s}" if dic.name == "Tag"
            end

            counter +=1
            #SKETCHUP_CONSOLE.hide

        end

    end
end # module

# Create menu items
unless file_loaded?(__FILE__)
    #mymenu = UI.menu("Plugins").add_submenu("My Plugin Collection")
    mymenu = UI.menu("Plugins")
    #mymenu.add_item("My Tool 1") {AddQuantities::addq}
    mymenu.add_item("Add Ifc Quantities") {AddQuantities::addq}
    #mymenu.add_item("My Tool 1") {AddQuantities}
    file_loaded(__FILE__)
   end