-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    sample_id,
    dna_sequence,
    species,
    CASE
        WHEN LEFT(dna_sequence, 3) = 'ATG' THEN 1 ELSE 0
    END AS "has_start",
    CASE
        WHEN RIGHT(dna_sequence, 3) IN ('TAA','TAG','TGA') THEN 1 ELSE 0
    END AS "has_stop",
    CASE
        WHEN dna_sequence ~ 'ATAT' THEN 1 ELSE 0
    END AS "has_atat",
    CASE
        WHEN dna_sequence ~ 'G{3,}' THEN 1 ELSE 0
    END AS "has_ggg"
FROM
    samples
---------------------------------------------- NOTES --------------------------------------------
--> Sequences that start with ATG (a common start codon)
--> Sequences that end with either TAA, TAG, or TGA (stop codons)
--> Sequences containing the motif ATAT (a simple repeated pattern)
--> Sequences that have at least 3 consecutive G (like GGG or GGGG)
-------------------------------------------------------------------------------------------------