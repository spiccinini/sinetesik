from django.core.management import setup_environ
import settings
import os, sys
import subprocess, shlex
import csv
import argparse



parser = argparse.ArgumentParser(description='Dump database to tsv.')
parser.add_argument('outfile', nargs='?', type=argparse.FileType('w'), default=sys.stdout)

args = parser.parse_args()

setup_environ(settings)

from panal_app.models import Proyectos, Usuarios, TipoArchivos, ProyectosProcesados

PATH_ARCHIVOS_WAV = "/home/san/Downloads/redpanal/originales_to_wav"

proyectos = ProyectosProcesados.objects.filter(to_wav_ok=True)
filewriter = csv.writer(args.outfile, delimiter='\t', quoting=csv.QUOTE_MINIMAL)

lista_hardcodeada = [
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/1.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/2.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/3.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/4.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/5.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/6.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/7.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/8.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/9.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/10.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/11.wav",
    "/Users/lf/Dropbox/Documentos/mediaLab/materiales/fullTracks/12.wav",
]
import random

for proyecto in proyectos:    
    if proyecto.tonalidad and proyecto.bpm:
        #print proyecto.archivo_wav, str(proyecto.bpm), str(proyecto.tonalidad)
        
        filewriter.writerow([random.choice(lista_hardcodeada), str(proyecto.bpm), str(proyecto.tonalidad)]) #FIXME: no usar la lista hardcdeada.
        #filewriter.writerow([proyecto.archivo_wav, str(proyecto.bpm), str(proyecto.tonalidad)])

