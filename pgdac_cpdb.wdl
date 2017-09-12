task pgdac_cpdb {
	#Inputs defined here
	File mut_vcf
	File junc_bed
	String id
	File annotation_zip	

	Int memory
	Int disk_space
	
	command {
		set -euo pipefail
		#Command goes here
		Rscript /src/customProDB.r ${mut_vcf} ${junc_bed} ${id} ${annotation_zip}
	}

	output {
		#Outputs defined here
		File snv_fasta="${id}_nsSNV.fasta"
		#File snv_info="${id}_nsSNV_INFO.xlsx"	
		File indel_fasta="${id}_indel.fasta"
		#File indel_info="${id}_indel_INFO.xlsx"
		File logfile="cpdb_${id}.log"
		File junc_fasta="${id}_junctions.fasta" 
	}

	runtime {
		docker : "broadcptac/pgdac_cpdb:2"
		memory : "${memory}GB"
		disks : "local-disk ${disk_space} HDD"
	}

	meta {
		author : "Karsten Krug"
		email : "karsten@broadinstitute.org"
	}

}

workflow pgdac_cpdb_workflow {
	call pgdac_cpdb
}
