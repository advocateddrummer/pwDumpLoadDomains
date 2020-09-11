# Pointwise V18.3R2 Journal file - Fri Sep 11 15:05:46 2020

package require PWI_Glyph 3.18.3

set dir /tmp
set prefix foo

set domainMask [pw::Display createSelectionMask -requireDomain {}]
pw::Display getSelectedEntities -selectionmask $domainMask domains
set nDomains [llength $domains(Domains)]

# There are no pre-selected domains, ask for them.
if {$nDomains == 0} {
  if {![pw::Display selectEntities -selectionmask $domainMask \
      -description "Select domain(s)" domains] } {
    set domains(Domains) ""
  }

  set nDomains [llength $domains(Domains)]

  if {$nDomains == 0} {
    puts "No domain(s) selected."
    exit
  }
}

puts "Exporting [llength $domains(Domains)] domains."

foreach d $domains(Domains) {
  #set _TMP(mode_1) [pw::Application begin GridExport [pw::Entity sort [list $_DM(1)]]]
  set domainName [$d getName]
  puts "Exporting $d to $dir/$prefix-$domainName.cgns"
  set gridExportMode [pw::Application begin GridExport $d]
    $gridExportMode initialize -strict -type CGNS $dir/$prefix-$domainName.cgns
    $gridExportMode verify
    $gridExportMode write
  $gridExportMode end
  unset gridExportMode
  puts "Done"
}
