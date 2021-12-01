# Create an entry in the Extension list that loads a script called
# addWall.rb.
require 'sketchup.rb'
require 'extensions.rb'

extension = SketchupExtension.new('AddWallFromEdge', 'AddWallFromEdge/addWall')
extension.version = '1.0'
extension.description = 'Add wall from selected Edge'
Sketchup.register_extension(extension, true)
