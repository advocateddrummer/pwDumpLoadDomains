# Pointwise V18.3R2 Journal file - Fri Sep 11 16:02:07 2020

package require PWI_Glyph 3.18.3

set dir /tmp
set prefix foo

set domains [glob $dir/$prefix*]
puts "found [llength $domains] domains..."
puts "     $domains"

foreach d $domains {
  set gridImportMode [pw::Application begin GridImport]
    $gridImportMode initialize -strict -type CGNS $d
    $gridImportMode setAttribute GridImportConditionData true
    $gridImportMode read
    $gridImportMode convert
  $gridImportMode end
  unset gridImportMode
}
pw::Application markUndoLevel {Import Grid}

