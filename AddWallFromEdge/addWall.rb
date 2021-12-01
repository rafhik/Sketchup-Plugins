#Add IFC Quantities PSet to selection


require 'sketchup.rb'
#require 'AddIfcQuantities_toSelection.rb'

module AddWallFromEdge
    #-------------SET SPECIFIED TASK NAME TO SELECTION-------------#
    # Aply task name if component

    def self.addWallFromSelection ()

        #crear una superficie desde una linea y añadirla a un componente

        model = Sketchup.active_model
        entities = model.active_entities
        instance = Sketchup.active_model.selection[0]


        if defined?(@thickness) then e = @thickness*2.54 else e = 12 end
        if defined?(@elevation) then ee = @elevation*2.54 else ee = 100 end

        prompts = ["Altura?", "Espesor?", "Nombre?"]
        defaults = [ee, e, "Wall"]
        input = UI.inputbox(prompts, defaults, "Medidas en cm")
        @elevation = input[0]/2.54
        @thickness = input[1]/2.54

        pts = []
        pts[0] = instance.start.position
        pts[1] = instance.end.position
        pts[2] = [instance.end.position[0], instance.end.position[1], @elevation]
        pts[3] = [instance.start.position[0], instance.start.position[1], @elevation]


        new_comp_def = Sketchup.active_model.definitions.add(input[2])
        newface = new_comp_def.entities.add_face(pts)
        newface.pushpull(@thickness, true)
        trans = Geom::Transformation.new
        Sketchup.active_model.active_entities.add_instance(new_comp_def, trans)

        prompts = ["Voltear s/n ?"]
        defaults = ["n"]
        input2 = UI.inputbox(prompts, defaults, "Voltear")
        if input2[0] == "s" or input2[0] == "S"
        Sketchup.undo
        Sketchup.undo
        newface.reverse!
        newface.pushpull(@thickness, true)
        #trans = Geom::Transformation.new
        Sketchup.active_model.active_entities.add_instance(new_comp_def, trans)
        end

    end
    
end


toolbar = UI::Toolbar.new("Wall")
cmd = UI::Command.new("Wall") {
    AddWallFromEdge::addWallFromSelection
}
cmd.small_icon = cmd.large_icon = "/Users/rafaelteresachinchilla/Library/Application\ Support/SketchUp\ 2021/SketchUp/Plugins/AddWallFromEdge/addWallLarge.png"
toolbar = toolbar.add_item(cmd)
toolbar.show




# Create menu items
unless file_loaded?(__FILE__)
    #mymenu = UI.menu("Plugins").add_submenu("My Plugin Collection")
    mymenu = UI.menu("Plugins")
    mymenu.add_item("Add Wall from Selection") {AddWallFromEdge::addWallFromSelection}
    file_loaded(__FILE__)
end