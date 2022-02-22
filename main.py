import argparse
import cv2
import math
import time

def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument()

def main():
    while True:
        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            break

if __name__ == '__main__':
    main()

