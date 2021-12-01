# Create an entry in the Extension list that loads a script called
# addWall.rb.
require 'sketchup.rb'
require 'extensions.rb'

extension = SketchupExtension.new('AddCornerIntersection', 'AddCornerIntersection/addCorner')
extension.version = '1.0'
extension.description = 'Cut corner intersection from selection'
Sketchup.register_extension(extension, true)
