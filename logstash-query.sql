SELECT
  l.id, 
  l.title, 
  l.type, 
  l.price, 
  l.area, 
  l."electricityFee",
  l."waterFee", 
  l.description, 
  l.utilities::text, 
  l.images::text,
  l."contactName", 
  l."contactPhone", 
  l.status, 
  l."viewCount",
  l."expiredAt", 
  l."createdAt",
  l."updatedAt",
  CONCAT(a.street, ', ', a.ward, ', ', a.district, ', ', a.city) AS "fullAddress",
  a.lat, 
  a.lng, 
  u.name AS "ownerName", 
  u.phone AS "ownerPhone"
FROM "Listing" l
JOIN "Address" a ON l."addressId" = a.id
JOIN "User" u ON l."ownerId" = u.id
WHERE l.status = 'ACTIVE'
AND l."updatedAt" > :sql_last_value
ORDER BY l."updatedAt" ASC
