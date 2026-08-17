-- Mutiple CASE statements to check the conditions for the patterns:

SELECT
    sample_id,
    dna_sequence,
    species,

-- condition 1: start with ATG:
    CASE WHEN LEFT(dna_sequence, 3) = 'ATG' THEN 1 ELSE 0 END AS has_start,

-- coniditon 2: end with TAA, TAG, or TGA:
    CASE WHEN RIGHT(dna_sequence, 3) IN ('TAA', 'TAG', 'TGA') THEN 1 ELSE 0 END AS has_stop,

-- condition 3: contains ATAT 
    CASE WHEN  dna_sequence LIKE '%ATAT%'THEN 1 ELSE 0 END AS has_atat,

-- condition 4: at least consecutive 3 G's 
    CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END AS has_ggg

FROM samples
ORDER BY sample_id ASC