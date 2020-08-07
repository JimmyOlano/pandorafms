<?php
// Copyright (c) 2011-2011 Ártica Soluciones Tecnológicas
// http://www.artica.es  <info@artica.es>
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; version 2
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// Turn on output buffering.
// The entire buffer will be discarded later so that any accidental output
// does not corrupt images generated by fgraph.
ob_start();

global $config;

if (empty($config['homedir'])) {
    include_once '../../include/config.php';
    global $config;
}

require_once $config['homedir'].'/include/functions.php';
require_once $config['homedir'].'/include/graphs/functions_flot.php';

$ttl = get_parameter('ttl', 1);
$graph_type = get_parameter('graph_type', '');

if (!empty($graph_type)) {
    include_once $config['homedir'].'/include/functions_html.php';
    include_once $config['homedir'].'/include/graphs/functions_gd.php';
    include_once $config['homedir'].'/include/graphs/functions_utils.php';
    include_once $config['homedir'].'/include/graphs/functions_d3.php';
    include_once $config['homedir'].'/include/graphs/functions_flot.php';
}

// Clean the output buffer and turn off output buffering
ob_end_clean();

switch ($graph_type) {
    case 'histogram':
        $width = get_parameter('width');
        $height = get_parameter('height');
        $data = json_decode(io_safe_output(get_parameter('data')), true);

        $max = get_parameter('max');
        $title = get_parameter('title');
        $mode = get_parameter('mode', 1);
        gd_histogram($width, $height, $mode, $data, $max, $config['fontpath'], $title);
    break;

    case 'progressbar':
        $width = get_parameter('width');
        $height = get_parameter('height');
        $progress = get_parameter('progress');

        $out_of_lim_str = io_safe_output(get_parameter('out_of_lim_str', false));
        $out_of_lim_image = get_parameter('out_of_lim_image', false);

        // Add relative path to avoid phar object injection.
        $out_of_lim_image = '../graphs/'.$out_of_lim_image;

        $title = get_parameter('title');

        $mode = get_parameter('mode', 1);

        $fontsize = get_parameter('fontsize', 10);

        $value_text = get_parameter('value_text', '');
        $colorRGB = get_parameter('colorRGB', '');

        gd_progress_bar(
            $width,
            $height,
            $progress,
            $title,
            $config['fontpath'],
            $out_of_lim_str,
            $out_of_lim_image,
            $mode,
            $fontsize,
            $value_text,
            $colorRGB
        );
    break;

    case 'progressbubble':
        $width = get_parameter('width');
        $height = get_parameter('height');
        $progress = get_parameter('progress');

        $out_of_lim_str = io_safe_output(get_parameter('out_of_lim_str', false));
        $out_of_lim_image = get_parameter('out_of_lim_image', false);

        $title = get_parameter('title');

        $mode = get_parameter('mode', 1);

        $fontsize = get_parameter('fontsize', 7);

        $value_text = get_parameter('value_text', '');
        $colorRGB = get_parameter('colorRGB', '');

        gd_progress_bubble(
            $width,
            $height,
            $progress,
            $title,
            $config['fontpath'],
            $out_of_lim_str,
            $out_of_lim_image,
            $mode,
            $fontsize,
            $value_text,
            $colorRGB
        );
    break;
}


function progressbar(
    $progress,
    $width,
    $height,
    $title,
    $font,
    $mode=1,
    $out_of_lim_str=false,
    $out_of_lim_image=false,
    $ttl=1
) {
    $graph = [];

    $graph['progress'] = $progress;
    $graph['width'] = $width;
    $graph['height'] = $height;
    $graph['out_of_lim_str'] = $out_of_lim_str;
    $graph['out_of_lim_image'] = $out_of_lim_image;
    $graph['title'] = $title;
    $graph['font'] = $font;
    $graph['mode'] = $mode;

    $id_graph = serialize_in_temp($graph, null, $ttl);
    if (is_metaconsole()) {
        return "<img src='../../include/graphs/functions_gd.php?static_graph=1&graph_type=progressbar&ttl=".$ttl.'&id_graph='.$id_graph."'>";
    } else {
        return "<img src='include/graphs/functions_gd.php?static_graph=1&graph_type=progressbar&ttl=".$ttl.'&id_graph='.$id_graph."'>";
    }
}


/**
 * Draw vertical bars graph.
 *
 * @param array   $data   Data chart.
 * @param array   $params Params draw chart.
 * @param integer $ttl    Pdf option.
 *
 * @return mixed
 */
function vbar_graph(
    array $data,
    array $options,
    int $ttl=1
) {
    global $config;

    // INFO IN: https://github.com/flot/flot/blob/master/API.md.
    // Xaxes chart Title.
    if (isset($options['x']['title']['title']) === false) {
        $options['x']['title']['title'] = '';
    }

    if (isset($options['x']['title']['fontSize']) === false) {
        $options['x']['title']['fontSize'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['x']['title']['fontFamily']) === false) {
        $options['x']['title']['fontFamily'] = preg_replace(
            '/.ttf/',
            'Font, Arial',
            $config['fontpath']
        );
    }

    if (isset($options['x']['title']['padding']) === false) {
        $options['x']['title']['padding'] = 10;
    }

    // Xaxes font ticks.
    if (isset($options['x']['font']['size']) === false) {
        $options['x']['font']['size'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['x']['font']['lineHeight']) === false) {
        $options['x']['font']['lineHeight'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['x']['font']['style']) === false) {
        $options['x']['font']['style'] = 'normal';
    }

    if (isset($options['x']['font']['weight']) === false) {
        $options['x']['font']['weight'] = 'normal';
    }

    if (isset($options['x']['font']['family']) === false) {
        $options['x']['font']['family'] = preg_replace(
            '/.ttf/',
            'Font',
            $config['fontpath']
        );
    }

    if (isset($options['x']['font']['variant']) === false) {
        $options['x']['font']['variant'] = 'small-caps';
    }

    if (isset($options['x']['font']['color']) === false) {
        $options['x']['font']['color'] = '#545454';
    }

    // Show ticks.
    if (isset($options['x']['show']) === false) {
        $options['x']['show'] = true;
    }

    // Type position bottom or top or left or right.
    if (isset($options['x']['position']) === false) {
        $options['x']['position'] = 'bottom';
    }

    // Grid color axes x.
    if (isset($options['x']['color']) === false) {
        $options['x']['color'] = '#ffffff';
    }

    if (isset($options['x']['labelWidth']) === false) {
        $options['x']['labelWidth'] = null;
    }

    if (isset($options['x']['labelHeight']) === false) {
        $options['x']['labelHeight'] = null;
    }

    // Yaxes chart Title.
    if (isset($options['y']['title']['title']) === false) {
        $options['y']['title']['title'] = '';
    }

    if (isset($options['y']['title']['fontSize']) === false) {
        $options['y']['title']['fontSize'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['y']['title']['fontFamily']) === false) {
        $options['y']['title']['fontFamily'] = preg_replace(
            '/.ttf/',
            'Font, Arial',
            $config['fontpath']
        );
    }

    if (isset($options['y']['title']['padding']) === false) {
        $options['y']['title']['padding'] = 10;
    }

    // Yaxes font ticks.
    if (isset($options['y']['font']['size']) === false) {
        $options['y']['font']['size'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['y']['font']['lineHeight']) === false) {
        $options['y']['font']['lineHeight'] = ((int) $config['font_size'] + 2);
    }

    if (isset($options['y']['font']['style']) === false) {
        $options['y']['font']['style'] = 'normal';
    }

    if (isset($options['y']['font']['weight']) === false) {
        $options['y']['font']['weight'] = 'normal';
    }

    if (isset($options['y']['font']['family']) === false) {
        $options['y']['font']['family'] = preg_replace(
            '/.ttf/',
            'Font',
            $config['fontpath']
        );
    }

    if (isset($options['y']['font']['variant']) === false) {
        $options['y']['font']['variant'] = 'small-caps';
    }

    if (isset($options['y']['font']['color']) === false) {
        $options['y']['font']['color'] = '#545454';
    }

    // Show ticks.
    if (isset($options['y']['show']) === false) {
        $options['y']['show'] = true;
    }

    // Type position bottom or top or left or right.
    if (isset($options['y']['position']) === false) {
        $options['y']['position'] = 'left';
    }

    // Grid color axes y.
    if (isset($options['y']['color']) === false) {
        $options['y']['color'] = '#ffffff';
    }

    if (isset($options['y']['labelWidth']) === false) {
        $options['y']['labelWidth'] = null;
    }

    if (isset($options['y']['labelHeight']) === false) {
        $options['y']['labelHeight'] = null;
    }

    // Bars options.
    // left, right or center.
    if (isset($options['bars']['align']) === false) {
        $options['bars']['align'] = 'center';
    }

    if (isset($options['bars']['barWidth']) === false) {
        $options['bars']['barWidth'] = 0.8;
    }

    if (isset($options['bars']['horizontal']) === false) {
        $options['bars']['horizontal'] = false;
    }

    // Grid Options.
    if (isset($options['grid']['show']) === false) {
        $options['grid']['show'] = true;
    }

    if (isset($options['grid']['aboveData']) === false) {
        $options['grid']['aboveData'] = false;
    }

    if (isset($options['grid']['color']) === false) {
        $options['grid']['color'] = '#ffffff';
    }

    if (isset($options['grid']['backgroundColor']) === false) {
        $options['grid']['backgroundColor'] = [
            'colors' => [
                '#ffffff',
                '#ffffff',
            ],
        ];
    }

    if (isset($options['grid']['margin']) === false) {
        $options['grid']['margin'] = 0;
    }

    if (isset($options['grid']['labelMargin']) === false) {
        $options['grid']['labelMargin'] = 5;
    }

    if (isset($options['grid']['axisMargin']) === false) {
        $options['grid']['axisMargin'] = 5;
    }

    if (isset($options['grid']['markings']) === false) {
        $options['grid']['markings'] = [];
    }

    if (isset($options['grid']['borderWidth']) === false) {
        $options['grid']['borderWidth'] = 0;
    }

    if (isset($options['grid']['borderColor']) === false) {
        $options['grid']['borderColor'] = '#ffffff';
    }

    if (isset($options['grid']['minBorderMargin']) === false) {
        $options['grid']['minBorderMargin'] = 5;
    }

    if (isset($options['grid']['clickable']) === false) {
        $options['grid']['clickable'] = false;
    }

    if (isset($options['grid']['hoverable']) === false) {
        $options['grid']['hoverable'] = false;
    }

    if (isset($options['grid']['autoHighlight']) === false) {
        $options['grid']['autoHighlight'] = false;
    }

    if (isset($options['grid']['mouseActiveRadius']) === false) {
        $options['grid']['mouseActiveRadius'] = false;
    }

    // Series bars.
    if (isset($options['seriesBars']['show']) === false) {
        $options['seriesBars']['show'] = true;
    }

    if (isset($options['seriesBars']['lineWidth']) === false) {
        $options['seriesBars']['lineWidth'] = 0.3;
    }

    if (isset($options['seriesBars']['fill']) === false) {
        $options['seriesBars']['fill'] = true;
    }

    if (isset($options['seriesBars']['fillColor']) === false) {
        $options['seriesBars']['fillColor'] = [
            'colors' => [
                [ 'opacity' => 0.9 ],
                [ 'opacity' => 0.9 ],
            ],
        ];
    };

    // Generals options.
    if (isset($options['generals']['unit']) === false) {
        $options['generals']['unit'] = '';
    }

    if (isset($options['generals']['divisor']) === false) {
        $options['generals']['divisor'] = 1000;
    }

    if (isset($options['generals']['forceTicks']) === false) {
        $options['generals']['forceTicks'] = false;
    }

    if (isset($options['generals']['arrayColors']) === false) {
        $options['generals']['arrayColors'] = false;
    }

    if (isset($options['generals']['rotate']) === false) {
        $options['generals']['rotate'] = false;
    }

    if (isset($options['generals']['pdf']['width']) === false) {
        $options['generals']['pdf']['width'] = false;
    }

    if (isset($options['generals']['pdf']['height']) === false) {
        $options['generals']['pdf']['height'] = false;
    }

    $params = [
        'data'       => $data,
        'x'          => [
            'title'       => [
                'title'      => $options['x']['title']['title'],
                'fontSize'   => $options['x']['title']['fontSize'],
                'fontFamily' => $options['x']['title']['fontFamily'],
                'padding'    => $options['x']['title']['padding'],
            ],
            'font'        => [
                'size'       => $options['x']['font']['size'],
                'lineHeight' => $options['x']['font']['lineHeight'],
                'style'      => $options['x']['font']['style'],
                'weight'     => $options['x']['font']['weight'],
                'family'     => $options['x']['font']['family'],
                'variant'    => $options['x']['font']['variant'],
                'color'      => $options['x']['font']['color'],
            ],
            'show'        => $options['x']['show'],
            'position'    => $options['x']['position'],
            'color'       => $options['x']['color'],
            'labelWidth'  => $options['x']['labelWidth'],
            'labelHeight' => $options['x']['labelHeight'],
        ],
        'y'          => [
            'title'       => [
                'title'      => $options['y']['title']['title'],
                'fontSize'   => $options['y']['title']['fontSize'],
                'fontFamily' => $options['y']['title']['fontFamily'],
                'padding'    => $options['y']['title']['padding'],
            ],
            'font'        => [
                'size'       => $options['y']['font']['size'],
                'lineHeight' => $options['y']['font']['lineHeight'],
                'style'      => $options['y']['font']['style'],
                'weight'     => $options['y']['font']['weight'],
                'family'     => $options['y']['font']['family'],
                'variant'    => $options['y']['font']['variant'],
                'color'      => $options['y']['font']['color'],
            ],
            'show'        => $options['y']['show'],
            'position'    => $options['y']['position'],
            'color'       => $options['y']['color'],
            'labelWidth'  => $options['y']['labelWidth'],
            'labelHeight' => $options['y']['labelHeight'],
        ],
        'bars'       => [
            'align'      => $options['bars']['align'],
            'barWidth'   => $options['bars']['barWidth'],
            'horizontal' => $options['bars']['horizontal'],
        ],
        'grid'       => [
            'show'              => $options['grid']['show'],
            'aboveData'         => $options['grid']['aboveData'],
            'color'             => $options['grid']['color'],
            'backgroundColor'   => $options['grid']['backgroundColor'],
            'margin'            => $options['grid']['margin'],
            'labelMargin'       => $options['grid']['labelMargin'],
            'axisMargin'        => $options['grid']['axisMargin'],
            'markings'          => $options['grid']['markings'],
            'borderWidth'       => $options['grid']['borderWidth'],
            'borderColor'       => $options['grid']['borderColor'],
            'minBorderMargin'   => $options['grid']['minBorderMargin'],
            'clickable'         => $options['grid']['clickable'],
            'hoverable'         => $options['grid']['hoverable'],
            'autoHighlight'     => $options['grid']['autoHighlight'],
            'mouseActiveRadius' => $options['grid']['mouseActiveRadius'],
        ],
        'seriesBars' => [
            'show'      => $options['seriesBars']['show'],
            'lineWidth' => $options['seriesBars']['lineWidth'],
            'fill'      => $options['seriesBars']['fill'],
            'fillColor' => $options['seriesBars']['fillColor'],
        ],
        'generals'   => [
            'unit'        => $options['generals']['unit'],
            'divisor'     => $options['generals']['divisor'],
            'forceTicks'  => $options['generals']['forceTicks'],
            'arrayColors' => $options['generals']['arrayColors'],
            'rotate'      => $options['generals']['rotate'],
        ],
    ];

    if (empty($params['data']) === true) {
        return graph_nodata_image(0, 0, 'vbar', '', true);
    }

    if ((int) $ttl === 2) {
        $params['backgroundColor'] = $options['grid']['backgroundColor'];
        $params['return_img_base_64'] = true;
        $params['generals']['pdf']['width'] = $options['generals']['pdf']['width'];
        $params['generals']['pdf']['height'] = $options['generals']['pdf']['height'];
        return generator_chart_to_pdf('vbar', $params);
    }

    return flot_vcolumn_chart($params);
}


function area_graph(
    $agent_module_id,
    $array_data,
    $legend,
    $series_type,
    $color,
    $date_array,
    $data_module_graph,
    $params,
    $water_mark,
    $array_events_alerts
) {
    global $config;

    include_once 'functions_flot.php';

    if ($water_mark !== false) {
        setup_watermark($water_mark, $water_mark_file, $water_mark_url);
    }

    return flot_area_graph(
        $agent_module_id,
        $array_data,
        $legend,
        $series_type,
        $color,
        $date_array,
        $data_module_graph,
        $params,
        $water_mark,
        $array_events_alerts
    );
}


function stacked_bullet_chart(
    $chart_data,
    $width,
    $height,
    $color,
    $legend,
    $long_index,
    $no_data_image,
    $xaxisname='',
    $yaxisname='',
    $water_mark='',
    $font='',
    $font_size='',
    $unit='',
    $ttl=1,
    $homeurl='',
    $backgroundColor='white'
) {
    include_once 'functions_d3.php';

    if ($water_mark !== false) {
        setup_watermark($water_mark, $water_mark_file, $water_mark_url);
    }

    if (empty($chart_data)) {
        return '<img src="'.$no_data_image.'" />';
    }

    return d3_bullet_chart(
        $chart_data,
        $width,
        $height,
        $color,
        $legend,
        $homeurl,
        $unit,
        $font,
        $font_size
    );

}


function stacked_gauge(
    $chart_data,
    $width,
    $height,
    $color,
    $legend,
    $no_data_image,
    $font='',
    $font_size='',
    $unit='',
    $homeurl='',
    $transitionDuration=500
) {
    include_once 'functions_d3.php';

    if (empty($chart_data)) {
        return '<img src="'.$no_data_image.'" />';
    }

    return d3_gauges(
        $chart_data,
        $width,
        $height,
        $color,
        $legend,
        $homeurl,
        $unit,
        $font,
        ($font_size + 2),
        $no_data_image,
        $transitionDuration
    );
}


function hbar_graph(
    $chart_data,
    $width,
    $height,
    $color,
    $legend,
    $long_index,
    $no_data_image,
    $xaxisname='',
    $yaxisname='',
    $water_mark='',
    $font='',
    $font_size='',
    $unit='',
    $ttl=1,
    $homeurl='',
    $backgroundColor='white',
    $tick_color='white',
    $val_min=null,
    $val_max=null,
    $base64=false
) {
    if ($water_mark !== false) {
        setup_watermark($water_mark, $water_mark_file, $water_mark_url);
    }

    if ($chart_data === false || empty($chart_data) === true) {
        return graph_nodata_image($width, $height, 'hbar');
    }

    if ($ttl == 2) {
        $params = [
            'chart_data'         => $chart_data,
            'width'              => $width,
            'height'             => $height,
            'water_mark_url'     => $water_mark_url,
            'font'               => $font,
            'font_size'          => $font_size,
            'backgroundColor'    => $backgroundColor,
            'tick_color'         => $tick_color,
            'val_min'            => $val_min,
            'val_max'            => $val_max,
            'return_img_base_64' => $base64,
        ];
        return generator_chart_to_pdf('hbar', $params);
    }

    return flot_hcolumn_chart(
        $chart_data,
        $width,
        $height,
        $water_mark_url,
        $font,
        $font_size,
        $backgroundColor,
        $tick_color,
        $val_min,
        $val_max
    );
}


function pie_graph(
    $chart_data,
    $width,
    $height,
    $others_str='other',
    $homedir='',
    $water_mark='',
    $font='',
    $font_size=8,
    $ttl=1,
    $legend_position=false,
    $colors='',
    $hide_labels=false
) {
    if (empty($chart_data) === true) {
        return graph_nodata_image($width, $height, 'pie');
    }

    if ($water_mark !== false) {
        setup_watermark($water_mark, $water_mark_file, $water_mark_url);
    }

    // This library allows only 8 colors.
    $max_values = 9;

    // Remove the html_entities.
    $temp = [];
    foreach ($chart_data as $key => $value) {
        $temp[io_safe_output($key)] = $value;
    }

    $chart_data = $temp;

    if (count($chart_data) > $max_values) {
        $chart_data_trunc = [];
        $n = 1;
        foreach ($chart_data as $key => $value) {
            if ($n < $max_values) {
                $chart_data_trunc[$key] = $value;
            } else {
                if (!isset($chart_data_trunc[$others_str])) {
                    $chart_data_trunc[$others_str] = 0;
                }

                $chart_data_trunc[$others_str] += $value;
            }

            $n++;
        }

        $chart_data = $chart_data_trunc;
    }

    if ($ttl == 2) {
        $params = [
            'values'          => array_values($chart_data),
            'keys'            => array_keys($chart_data),
            'width'           => $width,
            'height'          => $height,
            'water_mark_url'  => $water_mark_url,
            'font'            => $font,
            'font_size'       => $font_size,
            'legend_position' => $legend_position,
            'colors'          => $colors,
            'hide_labels'     => $hide_labels,
        ];

        return generator_chart_to_pdf('pie_chart', $params);
    }

    return flot_pie_chart(
        array_values($chart_data),
        array_keys($chart_data),
        $width,
        $height,
        $water_mark_url,
        $font,
        $font_size,
        $legend_position,
        $colors,
        $hide_labels
    );
}


function ring_graph(
    $chart_data,
    $width,
    $height,
    $others_str='other',
    $homedir='',
    $water_mark='',
    $font='',
    $font_size='',
    $ttl=1,
    $legend_position=false,
    $colors='',
    $hide_labels=false,
    $background_color='white'
) {
    if (empty($chart_data)) {
        return graph_nodata_image($width, $height, 'pie');
    }

    setup_watermark($water_mark, $water_mark_file, $water_mark_url);

    // This library allows only 8 colors
    $max_values = 18;

    if ($ttl == 2) {
        $params = [
            'chart_data'       => $chart_data,
            'width'            => $width,
            'height'           => $height,
            'colors'           => $colors,
            'module_name_list' => $module_name_list,
            'long_index'       => $long_index,
            'no_data'          => $no_data,
            'water_mark'       => $water_mark,
            'font'             => $font,
            'font_size'        => $font_size,
            'unit'             => $unit,
            'ttl'              => $ttl,
            'homeurl'          => $homeurl,
            'background_color' => $background_color,
            'legend_position'  => $legend_position,
            'background_color' => $background_color,
        ];

        return generator_chart_to_pdf('ring_graph', $params);
    }

    return flot_custom_pie_chart(
        $chart_data,
        $width,
        $height,
        $colors,
        $module_name_list,
        $long_index,
        $no_data,
        false,
        '',
        $water_mark,
        $font,
        $font_size,
        $unit,
        $ttl,
        $homeurl,
        $background_color,
        $legend_position,
        $background_color
    );
}
