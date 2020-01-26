#coding=utf-8
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--type', action='store', default='en2ch')
parser.add_argument('--content', action='store', default='')
parser.add_argument('--engine', action='store', default='aiciba')
args = parser.parse_args()
print(args)
print(args.content)
