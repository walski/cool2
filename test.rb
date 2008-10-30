require 'lib/cool2'
require 'cool2/latex'

def whole_document(list) 
  <<-eos
  \\documentclass{article}
  \\usepackage[utf8]{inputenc}
  \\usepackage[T1]{fontenc}

  \\title{Test Document}
  \\begin{document}
    #{list}
  \\end{document}
  eos
end


test = <<-eos
= Security (Absichern gegen böse Absichten) =
  - Ärzte melden sich nicht ordnungsgemäß vom Terminal im Patientenzimmer ab
    - Besucher können während der Patient nicht im Zimmer ist, oder während   
      dieser schläft/nicht ansprechbar ist, die Akte des Patienten auslesen und
      ändern. (Datenschutz / Authenzität)
    - Krankenschwestern können die Akte ändern (Authenzität)
    - Der Patient kann selbst seine Akte ändern um so beispielsweise die
      Krankenhausrechnung zu mindern (Authenzität)
  - Ein Angriff auf den Server der Patientenakte
    - Die Daten können von Unbefugten gelesen (Datenschutz) und geändert
      (Authenzität) werden.
    - Zudem kann die Verfügbarkeit des Servers von Angreifern beeinträchtigt
      werden wenn sie diesen beispielsweise durch einen Virus oder eine gezielte
      Manipulation lahmlegen
    - Durch gezielte Manipulation der Patientenakte können auch die 
      medizinischen Geräte im Patientenzimmer manipuliert werden  
      (Verlässlichkeit)
    - Dieser Angriff kann geschehen:
      - Von Außen (über das Internet)
      - Durch das unbefugte Eindringen in das Rechenzentrum des Servers
        (Angreifer täuscht vor Wartungstechniker zu sein und verschafft sich
        so physischen Zugang, Angriff über das Netzwerk des Rechenzentrums oder
        das Internet, Bestechung der Rechenzentrums Angestellten, Gewaltsames
        Eindringen in das Rechenzentrum)
  - Arzt als Single Point of Failure
    - Arzt wird beeinflusst (Bestechung, Gewalt...) um Daten der Patientenakte
      auszulesen (Datenschutz) oder zu verändern (Form von Authenzität auch 
      wenn der Arzt selbst die Daten verändert tut er dies nicht in seinem
      Sinne, es verändern also indirekt unbefugte den Inhalt und geben sich
      dabei als Arzt aus)
    - Gehalt des Arztes richtet sich nach seinen Diagnosen, er kann also ein
      Eigeninteresse daran haben die Patientenakte zu manipulieren 
  - Der Arzt kann von ihm gestellte in das Terminal eingegebene Diagnosen 
    abstreiten (Zurechenbarkeit) solange diese nicht digital signiert werden
    müssen.
  - Ein Angreifer kann durch eine Man-in-the-Middle zwischen dem Terminal im
    Patientenzimmer und dem Server der Patientenakte Daten verändern die auf
    dem Terminal eingegeben oder von diesem vom Server angefragt werden 
    (Integrität) oder auch die Kommunikation zwischen Terminal und Server stören
    (Verlässlichkeit)
  - Alle Personen mit Zugriff auf die Akte, sei es im Zimmer, am Server oder in
    der Verwaltung, können durch einen Angreifer beeinflusst (Erpressung,   
    Bestechung, Gewalt...) werden um so Daten der Patientenakte herauszugeben 
    (Datenschutz)
eos
latex = Cool2::Latex.parse(test)

File.open('/Users/walski/Desktop/test/test.tex', 'w') do |file|
   file.puts whole_document(latex)
end