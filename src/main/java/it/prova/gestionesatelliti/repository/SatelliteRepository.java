package it.prova.gestionesatelliti.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import it.prova.gestionesatelliti.model.Satellite;
import it.prova.gestionesatelliti.model.StatoSatellite;

public interface SatelliteRepository extends CrudRepository<Satellite, Long>, JpaSpecificationExecutor<Satellite> {
	
	@Modifying
	@Query(value = "update Satellite s set s.dataLancio = ?1,s.stato = ?2 where id = ?3 ")
	public void lancio (LocalDate now, StatoSatellite stato, Long id);
	
	@Modifying
	@Query(value = "update Satellite s set s.dataRientro = ?1 , s.stato =?2 where id = ?3")
	public void rientro(LocalDate now, StatoSatellite stato, Long id);
	
}
