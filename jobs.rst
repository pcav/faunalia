.. meta::
   :description: Our experience and customers around the globe
   :keywords: Open Source, Free Software, Software libero, GIS, SIG, QGIS, Quantum GIS, GRASS, SAGA, OTB, PostGIS, PostgreSQL, OsGeo, OGC, lavori, clienti, jobs, clients, travaux, clients

.. |it| image:: images/italy.png
.. |pt| image:: images/portugal.png

Attività svolte
-------------------------------------------------------------------------------

Mappa dei lavori di Faunalia
...............................................................................

.. figure:: images/jobs_map.jpg
   :scale: 50%
   :alt: Faunalia job locations

   `Esplora la mappa <https://lizmap.faunalia.eu/index.php/view/map/?repository=faunalia&project=faunalia_it>`_

.. raw:: html

	<?php require_once('/usr/local/src/website_scripts/backend_ufficio.inc'); ?>

Maggiori clienti
...............................................................................

.. raw:: html
	
	<?php 
		$amm = array();
		$uni = array(); 
		$soc = array();
		$org = array();
		getListsOfCommittenti(_("it"), $amm, $uni, $soc, $org);
	?>
	
Amministrazione pubblica
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. raw:: html
	
	<?php printListOfCommittenti($amm); ?>

Università e centri di ricerca
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. raw:: html
	
	<?php printListOfCommittenti($uni); ?>

Società
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. raw:: html
	
	<?php printListOfCommittenti($soc); ?>

Associazioni e organizzazioni
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. raw:: html

	<?php printListOfCommittenti($org); ?>

Corsi e workshop
...............................................................................
.. raw:: html
	
	<?php getTableOfLavoriGis(); ?>

Assistenza e sviluppo
...............................................................................
.. raw:: html
	
	<?php getTableOfLavoriGis(true); ?>

Pubblicazioni
...............................................................................

.. raw:: html

	<?php printListOfPubblicazioniFreeGis(); ?>
