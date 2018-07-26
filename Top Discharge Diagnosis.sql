select top 50 
			  temp.description,
			  temp.code,

		   (select count(p.patient_id) 
			from patient_discharge_nl_view as pdv inner join patient_visit_diagnosis_view as pv on pv.patient_visit_id = pdv.patient_visit_id
			 									  inner join patient as p on p.patient_id = pv.patient_id
												  inner join person_formatted_name_iview as pfn on pfn.person_id = p.patient_id
												  inner join coding_system_element_description as cse on cse.code = pv.code
			where month(pdv.discharge_date_time) = 10   and 
					year(pdv.discharge_date_time) = (2017 -1) and
					pv.diagnosis_type_rcd = 'dis' and
					pv.coding_type_rcd = 'pri' and
					pv.code = temp.code) as mycount_2017,

            temp.mycount_2018
from
(
	select code,
		   [description],
		   main_pv.coding_system_rcd,

		   (select count(p.patient_id) 
			from patient_discharge_nl_view as pdv inner join patient_visit_diagnosis_view as pv on pv.patient_visit_id = pdv.patient_visit_id
			 									  inner join patient as p on p.patient_id = pv.patient_id
												  inner join person_formatted_name_iview as pfn on pfn.person_id = p.patient_id
												  inner join coding_system_element_description as cse on cse.code = pv.code
			where month(pdv.discharge_date_time) = 10   and 
					year(pdv.discharge_date_time) = 2017 and
					pv.diagnosis_type_rcd = 'dis' and
					pv.coding_type_rcd = 'pri' and
					pv.code = main_pv.code) as mycount_2018
					
	from coding_system_element_description as main_pv
	where coding_system_rcd = 'ICD10'
	
) as temp
order by temp.mycount_2018 DESC