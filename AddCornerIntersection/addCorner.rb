#Add IFC Quantities PSet to selection


require 'sketchup.rb'
#require 'AddIfcQuantities_toSelection.rb'

module AddCornerIntersect
    #-------------SET SPECIFIED TASK NAME TO SELECTION-------------#
    # Aply task name if component

    def self.addCornerIntersectFromSelection ()

        entities = Sketchup.active_model.entities
        instance0 = Sketchup.active_model.selection[0]
        instance1 = Sketchup.active_model.selection[1]
        provname = instance1.definition.name
        definition1 = instance1.definition
        instance0b = entities.add_instance(instance0.definition, IDENTITY)
        instance0b.make_unique
        instance1b = entities.add_instance(instance1.definition, IDENTITY)
        instance1b.make_unique
        result = instance0b.subtract(instance1b)
        instance3 = result.to_component
        result2 = instance1.erase!
        instance3.definition.name= provname

    end
    
end


toolbar = UI::Toolbar.new("Wall")
cmd = UI::Command.new("Corner") {
    AddCornerIntersect::addCornerIntersectFromSelection
}
cmd.small_icon = cmd.large_icon = "AddCornerIntersection/CornerSmall.png"
toolbar = toolbar.add_item(cmd)
toolbar.show




# Create menu items
unless file_loaded?(__FILE__)
    #mymenu = UI.menu("Plugins").add_submenu("My Plugin Collection")
    mymenu = UI.menu("Plugins")
    mymenu.add_item("Create corner intersection") {AddCornerIntersect::addCornerIntersectFromSelection}
    file_loaded(__FILE__)
end
