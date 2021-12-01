# Create an entry in the Extension list that loads a script called
# core.rb.
require 'sketchup.rb'
require 'extensions.rb'

extension = SketchupExtension.new('AddIFCQuantities', 'AddIFCQuantities/core')
extension.version = '1.0'
extension.description = 'Add IFC PsetQuantityTakeOff'
Sketchup.register_extension(extension, true)
