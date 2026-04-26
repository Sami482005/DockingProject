#!/bin/bash

# Purpose: Prepare receptor and ligand for docking

# Paths
MGLTOOLS=~/mgltools_x86_64Linux2_1.5.7
UTILS=$MGLTOOLS/MGLToolsPckgs/AutoDockTools/Utilities24
PYTHON=$MGLTOOLS/bin/pythonsh

# RECEPTOR PREP

# Remove water + heteroatoms
grep -Ev "HOH|HETATM" 4O75.pdb > receptor_clean.pdb

# Prepare receptor
$PYTHON $UTILS/prepare_receptor4.py \
    -r receptor_clean.pdb \
    -o receptor.pdbqt \
    -A checkhydrogens

# LIGAND PREP

# Convert SDF → MOL2
/usr/bin/obabel 2RC.sdf -O 2RC.mol2 --gen3d --minimize --ff MMFF94

# Prepare ligand
$PYTHON $UTILS/prepare_ligand4.py \
    -l 2RC.mol2 \
    -o 2RC.pdbqt