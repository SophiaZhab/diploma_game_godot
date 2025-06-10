shader_type canvas_item;

uniform float cloud_speed : hint_range(0.0, 1.0) = 0.2;
uniform float cloud_scale : hint_range(0.1, 5.0) = 1.5;
uniform float cloud_density : hint_range(0.0, 1.0) = 0.7;
uniform float cloud_coverage : hint_range(0.0, 1.0) = 0.6;

uniform vec4 shadow_color : source_color = vec4(0.1, 0.1, 0.15, 0.8);
uniform vec4 deep_shadow_color : source_color = vec4(0.05, 0.05, 0.08, 0.9);
uniform float contrast : hint_range(0.5, 3.0) = 1.8;
uniform float edge_softness : hint_range(0.0, 1.0) = 0.5;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;

    for (int i = 0; i < 6; i++) {
        value += amplitude * noise(p * frequency);
        amplitude *= 0.5;
        frequency *= 2.0;
    }

    return value;
}

void fragment() {
    vec2 uv = UV;

    float slow_time = TIME * cloud_speed * 0.1;
    vec2 main_wind = vec2(slow_time, slow_time * 0.3);

    vec2 cloud_uv1 = uv * cloud_scale + main_wind;
    vec2 cloud_uv2 = uv * cloud_scale * 0.8 + main_wind * 0.7 + vec2(slow_time * 0.2, 0.0);
    vec2 cloud_uv3 = uv * cloud_scale * 1.2 + main_wind * 1.2 + vec2(0.0, slow_time * 0.1);
    float cloud1 = fbm(cloud_uv1);
    float cloud2 = fbm(cloud_uv2);
    float cloud3 = fbm(cloud_uv3);

    // Комбінуємо шари
    float combined = (cloud1 * 0.5 + cloud2 * 0.3 + cloud3 * 0.2);

    // Зменшуємо турбулентність для менших звивань
    vec2 turbulence_uv = uv * 1.5 + slow_time * 0.05;
    float turbulence = fbm(turbulence_uv) * 0.1;
    combined += turbulence;

    combined = pow(combined, contrast);

    float soft_range = 0.05 + edge_softness * 0.15;
    float sharp_cutoff = step(1.0 - cloud_coverage, combined);
    float smooth_cutoff = smoothstep(1.0 - cloud_coverage - soft_range, 1.0 - cloud_coverage + soft_range, combined);
    combined = mix(sharp_cutoff, smooth_cutoff, edge_softness) * combined;

    float soft_gradient = smoothstep(0.3, 0.8, combined);
    float sharp_gradient = step(0.4, combined) * 0.5 + step(0.7, combined) * 0.5;
    float density_gradient = mix(sharp_gradient, soft_gradient, edge_softness);

    vec4 final_color = mix(shadow_color, deep_shadow_color, density_gradient);

    float alpha_variation = combined * cloud_density;
    final_color.a *= alpha_variation;

    float soft_edge = 1.0 - smoothstep(0.1, 0.4, combined);
    float sharp_edge = step(0.3, combined);
    float edge_effect = mix(sharp_edge, 1.0 - soft_edge * 0.3, edge_softness);
    final_color.a *= edge_effect;

    COLOR = final_color;
}