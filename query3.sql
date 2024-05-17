select
	r.date,
    st.first_name,
    st.last_name,
    st.sal_per_hour,
    sh.start_time,
    sh.end_time,
    ((hour(timediff(sh.end_time, sh.start_time))*60) + (minute(timediff(sh.end_time, sh.start_time))))/60 as hour_in_shift,
    (((hour(timediff(sh.end_time, sh.start_time))*60) + (minute(timediff(sh.end_time, sh.start_time))))/60) * st.sal_per_hour as staff_cost
from rota r
left join staff st on st.staff_id = r.staff_id
left join shift sh on sh.shift_id = r.shift_id