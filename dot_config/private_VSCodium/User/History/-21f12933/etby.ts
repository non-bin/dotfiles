import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals }) => {
  const db = locals.db;

  const query = `
SELECT
    artists.id AS artist_id,
    artists.name AS artist_name,
    SUM(v.end_time - v.start_time) AS total_visit_duration,
    COUNT(v.id) AS unique_session_count
FROM
    artists
JOIN
    (SELECT DISTINCT artist_id, session_id FROM visits) visitor ON artists.id = visitor.artist_id
    visits visit ON artists.id = visit.artist_id
GROUP BY
    artists.id
`;

  const data = await db.prepare(query).all();
  console.dir(data, { depth: null });

  return {
    data
  };
};
