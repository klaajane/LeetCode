-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    sample_id,
    dna_sequence,
    species,
    --- ATG Condition:
    CASE
        WHEN LEFT(dna_sequence, 3) = 'ATG' THEN 1 ELSE 0
    END AS "has_start",
    --- TAA, TAG, TGA Condition:
    CASE
        WHEN dna_sequence LIKE '%TAA'
          OR dna_sequence LIKE '%TAG'
          OR dna_sequence LIKE '%TGA'
        THEN 1 ELSE 0
    END AS "has_stop",
    --- ATAT Condition:
    CASE
        WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 -- helped optimize the query
        --WHEN dna_sequence ~ 'ATAT' THEN 1 ELSE 0
    END AS "has_atat",
    --- GGG Condition:
    CASE
        WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 -- helped optimize the query
        --WHEN dna_sequence ~ 'G{3,}' THEN 1 ELSE 0
    END AS "has_ggg"
FROM
    samples
ORDER BY
    sample_id
---------------------------------------------- NOTES --------------------------------------------
--> Sequences that start with ATG (a common start codon)
--> Sequences that end with either TAA, TAG, or TGA (stop codons)
--> Sequences containing the motif ATAT (a simple repeated pattern)
--> Sequences that have at least 3 consecutive G (like GGG or GGGG)
------------------------------------------ OPTIMZATINON -----------------------------------------
--> the above query was slow, here's some tips I found to optimize it:
--> Regex '~' is performance taxing. Use LIKE instead
-------------------------------------------------------------------------------------------------