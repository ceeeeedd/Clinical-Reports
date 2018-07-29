select a.creation_date_time,
	   format(a.creation_date_time,'hh:mm tt') as [Time],
	   a.hn,
	   a.patient_name,
	   a.current_bed,
	   a.ward,
	   a.date_of_birth,
	   a.age,
	   a.sex_rcd,
	   a.patient_height,
	   a.patient_weight,
	   a.bmi,
	   b.modified_by,
	   b.comment,
	   b.lu_updated,
	   format(b.lu_updated,'hh:mm tt') as [Mtime],
	   case when  b.active_flag =1 then 'Active' else 'Inactive' end as Status
from cnl.nutrition_referral a
inner join cnl.person_indicator b on a.person_id = b.person_id
where b.person_indicator_id in (select top 4 aa.person_indicator_id  from cnl.person_indicator aa
								where aa.person_indicator_rcd = 'E854F'
								and aa.person_id = b.person_id
								and cast(convert(varchar(10),aa.lu_updated,101) as smalldatetime) >= cast(convert(varchar(10),'07/01/2018',101) as smalldatetime)
								and cast(convert(varchar(10),aa.lu_updated,101) as smalldatetime) <= cast(convert(varchar(10),'07/27/2018',101) as smalldatetime)
								order by aa.lu_updated)
								order by a.patient_name,
										 b.lu_updated