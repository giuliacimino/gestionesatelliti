package it.prova.gestionesatelliti.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.Predicate;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import it.prova.gestionesatelliti.model.Satellite;
import it.prova.gestionesatelliti.model.StatoSatellite;
import it.prova.gestionesatelliti.repository.SatelliteRepository;

@Service
public class SatelliteServiceImpl implements SatelliteService {
	@Autowired
	private SatelliteRepository satelliteRepository;

	@Override
	@Transactional(readOnly = true)
	public List<Satellite> listAllElements() {
		return (List<Satellite>) satelliteRepository.findAll();
	}

	@Override
	@Transactional(readOnly = true)
	public Satellite caricaSingoloElemento(Long id) {
		return satelliteRepository.findById(id).orElse(null);
	}

	@Override
	@Transactional
	public void aggiorna(Satellite satelliteInstance) {
		satelliteRepository.save(satelliteInstance);

	}

	@Override
	@Transactional
	public void inserisci(Satellite satelliteInstance) {
		satelliteRepository.save(satelliteInstance);
	}

	@Override
	@Transactional
	public void rimuovi(Long idSatellite) {
		satelliteRepository.deleteById(idSatellite);

	}

	@Override
	@Transactional(readOnly = true)
	public List<Satellite> findByExample(Satellite example) {
		Specification<Satellite> specificationCriteria = (root, query, cb) -> {

			List<Predicate> predicates = new ArrayList<Predicate>();

			if (StringUtils.isNotEmpty(example.getCodice()))
				predicates.add(cb.like(cb.upper(root.get("codice")), "%" + example.getCodice().toUpperCase() + "%"));

			if (StringUtils.isNotEmpty(example.getDenominazione()))
				predicates.add(
						cb.like(cb.upper(root.get("denominazione")), "%" + example.getDenominazione().toUpperCase() + "%"));

			if (example.getDataLancio() != null)
				predicates.add(cb.greaterThanOrEqualTo(root.get("dataLancio"), example.getDataLancio()));

			if (example.getStato() != null)
				predicates.add(cb.equal(root.get("stato"), example.getStato()));

			if (example.getDataRientro() != null)
				predicates.add(cb.greaterThanOrEqualTo(root.get("dataRientro"), example.getDataRientro()));

			return cb.and(predicates.toArray(new Predicate[predicates.size()]));
		};
		return satelliteRepository.findAll(specificationCriteria);
	}

	@Override
	@Transactional
	public void lancio(LocalDate now, StatoSatellite stato, Long id) {
		now= LocalDate.now();
		stato= StatoSatellite.IN_MOVIMENTO;
		satelliteRepository.lancio(now, stato, id);
		
		
	}

	@Override
	@Transactional
	public void rientro(LocalDate now, StatoSatellite stato, Long id) {
		now = LocalDate.now();
		stato = StatoSatellite.DISATTIVATO;
		satelliteRepository.rientro(now, stato, id);
		;

	}

	@Override
	@Transactional(readOnly = true)
	public List<Satellite> trovaSatellitiLanciatiDaPiuDiDueAnniNonDisattivati(LocalDate dataLancio,
			StatoSatellite stato) {
		dataLancio= LocalDate.of(2021, 05, 07);
		stato= StatoSatellite.DISATTIVATO;
		return satelliteRepository.findByDataLancioGreaterThanAndStatoLike(dataLancio, stato);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Satellite> trovaSatellitiDisattivatiMaNonRientrati(StatoSatellite stato) {
		stato= StatoSatellite.DISATTIVATO;
		return satelliteRepository.findByStatoDisattivatoAndDataRientroNull(stato);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Satellite> trovaInOrbitaDieciAnniEFissi(LocalDate dataLancio, StatoSatellite stato) {
		return satelliteRepository.findAllByDataLancioBeforeAndStato(LocalDate.of(2013, 05, 07), StatoSatellite.FISSO);
		
	}
}
