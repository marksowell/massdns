#!/usr/bin/python3

import argparse
import asyncio
import json
import os
import subprocess
import sys
import tempfile
from typing import Optional

import dns.asyncresolver
import tqdm

TEMP_PREFIX = 'massdns'
tempdir = None

def massdns_find_path():
    script_dir = os.path.dirname(os.path.realpath(__file__))
    massdns_git_path = os.path.realpath(os.path.join(script_dir, '..', 'bin', 'massdns'))
    if os.access(massdns_git_path, os.F_OK | os.X_OK):
        return mass
