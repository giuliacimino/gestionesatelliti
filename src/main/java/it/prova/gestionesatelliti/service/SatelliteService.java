package it.prova.gestionesatelliti.service;

import java.time.LocalDate;
import java.util.List;

import it.prova.gestionesatelliti.model.Satellite;
import it.prova.gestionesatelliti.model.StatoSatellite;

public interface SatelliteService {
public List<Satellite> listAllElements();
	
	public Satellite caricaSingoloElemento (Long id);
	
	public void aggiorna (Satellite satelliteInstance);

	public void inserisci (Satellite satelliteInstance);
	
	public void rimuovi (Long idSatellite);
	
	public List<Satellite> findByExample(Satellite example);
	
	public void lancio (LocalDate now, StatoSatellite stato, Long id);
	
	public void rientro (LocalDate now, StatoSatellite stato, Long id);
	
	public List<Satellite> trovaSatellitiLanciatiDaPiuDiDueAnniNonDisattivati (LocalDate dataLancio, StatoSatellite stato);
	
	public List<Satellite> trovaSatellitiDisattivatiMaNonRientrati (StatoSatellite stato);
	
	public List<Satellite> trovaInOrbitaDieciAnniEFissi (LocalDate dataLancio, StatoSatellite stato);
	
	public List<Satellite> partitiMaNonRientratiAttivi ();	
	
	public void effettuaEmergenza (LocalDate dataRientro, StatoSatellite stato);
	


}
