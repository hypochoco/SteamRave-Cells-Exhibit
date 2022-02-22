import argparse
import colorsys

import cv2
import numpy as np

#  def parse_args():
#  ap = argparse.ArgumentParser()
#  ap.add_argument()
#


def main():

    col_hue = 0.0
    col_hue_rot_speed = 1.0 / 360
    col_sat = 90 / 100
    col_val = 80 / 100

    rect_hue = 90.0 - col_hue
    rect_hue_rot_speed = 1.0 / 360
    rect_sat = 0.5 * col_sat
    rect_val = 1.2 * col_val

    depth_change = 1.05
    orig_depth = 0.2

    intervals = 6
    width = 1279
    height = int(width / intervals)
    rect_width_offset = int(orig_depth * height)
    rect_height_offset = rect_width_offset

    min_depth = rect_width_offset
    max_depth = int(0.95 * height)

    image = np.zeros((height, width, 3), np.uint8)

    while True:
        col = colorsys.hsv_to_rgb(col_hue, col_sat, col_val)
        col_r, col_g, col_b = (
            np.uint8(col[0] * 255),
            np.uint8(col[1] * 255),
            np.uint8(col[2] * 255),
        )

        opp_col = colorsys.hsv_to_rgb(abs(0.5 - col_hue), col_sat, col_val)
        opp_col_r, opp_col_g, opp_col_b = (
            np.uint8(opp_col[0] * 255),
            np.uint8(opp_col[1] * 255),
            np.uint8(opp_col[2] * 255),
        )

        rect_col_hsv = colorsys.hsv_to_rgb(rect_hue, rect_sat, rect_val)
        rect_col_r, rect_col_g, rect_col_b = (
            np.uint8(rect_col_hsv[0] * 255),
            np.uint8(rect_col_hsv[1] * 255),
            np.uint8(rect_col_hsv[2] * 255),
        )

        rect_opp_col_hsv = colorsys.hsv_to_rgb(abs(0.5 - rect_hue), rect_sat, rect_val)
        rect_opp_col_r, rect_opp_col_g, rect_opp_col_b = (
            np.uint8(rect_opp_col_hsv[0] * 255),
            np.uint8(rect_opp_col_hsv[1] * 255),
            np.uint8(rect_opp_col_hsv[2] * 255),
        )

        for i in range(intervals):
            start_idx = int((i / intervals) * width)
            end_idx = int((i + 1) / intervals * width)

            cur_col = (col_b, col_g, col_r)
            rect_col = (rect_col_b, rect_col_g, rect_col_r)
            if i % 2 == 1:
                cur_col = (opp_col_b, opp_col_g, opp_col_r)
                rect_col = (rect_opp_col_b, rect_opp_col_g, rect_opp_col_r)

            if i == 0:
                image[:rect_height_offset, start_idx:end_idx, :] = cur_col
                image[height - rect_height_offset :, start_idx:end_idx, :] = cur_col
                image[:, :rect_width_offset, :] = cur_col

                image[
                    rect_height_offset : height - rect_height_offset,
                    rect_width_offset:end_idx,
                    :,
                ] = rect_col
            elif i == (intervals - 1):
                image[:rect_height_offset, start_idx:end_idx, :] = cur_col
                image[height - rect_height_offset :, start_idx:end_idx, :] = cur_col
                image[:, width - rect_width_offset :, :] = cur_col

                image[
                    rect_height_offset : height - rect_height_offset,
                    start_idx : width - rect_width_offset,
                    :,
                ] = rect_col
            else:
                image[:rect_height_offset, start_idx:end_idx, :] = cur_col
                image[height - rect_height_offset :, start_idx:end_idx, :] = cur_col

                image[
                    rect_height_offset : height - rect_height_offset,
                    start_idx:end_idx,
                    :,
                ] = rect_col

        cv2.imshow("image", image)
        key = cv2.waitKey(50) & 0xFF

        if key == ord("q"):
            break

        col_hue = ((360 * (col_hue + col_hue_rot_speed)) % 360) / 360
        rect_hue = ((360 * (rect_hue + rect_hue_rot_speed)) % 360) / 360

        rect_width_offset = int(depth_change * rect_width_offset)
        print(rect_width_offset)
        rect_height_offset = rect_width_offset

        if rect_width_offset > max_depth:
            depth_change = 1 / depth_change
        elif rect_width_offset < min_depth:
            depth_change = 1 / depth_change
            rect_width_offset = int(orig_depth * height)
            rect_height_offset = rect_width_offset

    cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
