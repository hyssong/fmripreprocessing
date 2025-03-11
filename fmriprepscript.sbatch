#!/bin/bash
#SBATCH --job-name=1001
#SBATCH --time=34:00:00
#SBATCH --partition=broadwl
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=20
#SBATCH --mem-per-cpu=2800
#SBATCH --cpus-per-task=1

module load singularity
#singularity build fmriprep.simg docker://nipreps/fmriprep:latest
export SINGULARITYENV_FS_LICENSE=/fmriprep/license.txt

subject="1001"
BIDS_DIR="/fmriprep/bids"
OUTPUT_DIR="/fmriprep/fmriprepoutput/sub-${subject}"
WORK_DIR="/fmriprep/fmriprepwork/sub-${subject}"

singularity run -e /fmriprep/fmriprep.simg \
${BIDS_DIR} ${OUTPUT_DIR} participant \
-w ${WORK_DIR} \
--participant-label ${subject} \
--output-spaces MNI152NLin2009cAsym:res-2 \
--skip_bids_validation \
--ignore {fieldmaps,slicetiming}

