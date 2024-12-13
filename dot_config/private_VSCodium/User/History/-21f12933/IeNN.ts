import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals }) => {
  const db = locals.db;

  const query = `
SELECT
    a.id AS artist_id,
    a.name AS artist_name,
    SUM(v.end_time - v.start_time) AS total_visit_duration,
    COUNT(DISTINCT v.id) AS unique_session_count
FROM
    artists a
JOIN
    visits v ON a.id = v.artist_id
GROUP BY
    a.id
`;

  const data = await db.prepare(query).all();
  console.dir(data, { depth: null });

  return {
    data
  };
};
