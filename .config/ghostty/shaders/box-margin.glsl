// tmux 浮动 pane 边框：把框线往外推到边框格子的外沿，框外不再留白。
// 写死格子尺寸 17x36（设备像素）、网格起点和边框色，换字体/主题/padding 要改这里。
// 所有改动都落在边框字符自己的格子里，所以按格子判断：先看本格是不是 ─│┌┐└┘，
// 再决定格内哪些像素画线，不逐像素搜索。
const vec2 CELL = vec2(17.0, 36.0);
const vec2 GRID = vec2(4.0, 4.0); // 网格左上角离窗口左上角：window-padding 2pt × 2
// 制表符在格子里的位置（左上原点）：横线占第 17、18 行，竖线占第 7、8 列
const float LINE_Y = 17.0;
const float LINE_X = 7.0;
const float LINE_W = 2.0;
const float INSET = 8.0;        // 内边框离外边框的间隙
const float INNER_W = 2.0;      // 内边框线宽
const float INNER_ALPHA = 0.35; // 内边框的边框色浓度
// tmux themeyellow = darkgoldenrod #b8860b，iChannel0 里是 Display P3 编码
const vec3 BORDER = vec3(0.6919, 0.5336, 0.1846);
// 非聚焦浮动 pane：pane-border-style 的 themelightgrey #cccccc
const vec3 BORDER_INACTIVE = vec3(0.8);

// 本格框线的颜色，mainImage 里定
vec3 K;

bool same(vec3 a, vec3 b) {
    vec3 d = a - b;
    return dot(d, d) < 0.003;
}

// 格子 c 里左上原点的像素 o（Ghostty 在 macOS 上 fragCoord 原点在左上，y 向下）
vec3 at(vec2 c, vec2 o) {
    return texture(iChannel0, (GRID + c * CELL + o + 0.5) / iResolution.xy).rgb;
}

bool on(vec2 c, float x, float y) {
    return same(at(c, vec2(x, y)), K);
}

bool armL(vec2 c) { return on(c, 2.0, LINE_Y); }
bool armR(vec2 c) { return on(c, CELL.x - 3.0, LINE_Y); }
bool armU(vec2 c) { return on(c, LINE_X, 6.0); }
bool armD(vec2 c) { return on(c, LINE_X, CELL.y - 7.0); }

bool isCorner(vec2 c, bool r, bool d) {
    return armR(c) == r && armL(c) != r && armD(c) == d && armU(c) != d;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec3 c = texture(iChannel0, fragCoord / iResolution.xy).rgb;
    fragColor = vec4(c, 1.0);

    vec2 t = fragCoord - GRID;
    vec2 cell = floor(t / CELL);
    vec2 o = floor(t - cell * CELL);
    if (cell.x < 0.0 || cell.y < 0.0) return;
    // 每种框字符都经过横竖线交点
    K = at(cell, vec2(LINE_X, LINE_Y));
    if (!same(K, BORDER) && !same(K, BORDER_INACTIVE)) return;

    bool l = armL(cell), r = armR(cell), u = armU(cell), d = armD(cell);
    bool top = false, bottom = false, left = false, right = false;
    if (l && r && !u && !d) {
        // ─：往左走到这段线的起点，是 ┌ 就是上边，是 └ 就是下边
        vec2 e = cell - vec2(1.0, 0.0);
        while (e.x >= 0.0 && armL(e)) e.x -= 1.0;
        if (e.x < 0.0) return;
        top = isCorner(e, true, true);
        bottom = isCorner(e, true, false);
    } else if (u && d && !l && !r) {
        // │：往上走到这段线的起点，是 ┌ 就是左边，是 ┐ 就是右边
        vec2 e = cell - vec2(0.0, 1.0);
        while (e.y >= 0.0 && armU(e)) e.y -= 1.0;
        if (e.y < 0.0) return;
        left = isCorner(e, true, true);
        right = isCorner(e, false, true);
    } else if (!(l && r) && !(u && d) && (l || r) && (u || d)) {
        top = d;
        bottom = u;
        left = r;
        right = l;
    }
    if (!(top || bottom || left || right)) return;

    // 外边框贴着格子外沿
    if ((top && o.y < LINE_W) || (bottom && o.y >= CELL.y - LINE_W) ||
        (left && o.x < LINE_W) || (right && o.x >= CELL.x - LINE_W)) {
        fragColor = vec4(K, 1.0);
        return;
    }

    // 旧线擦掉，用格子左上角的底色（框字符不会经过那里）
    if (same(c, K)) fragColor = vec4(at(cell, vec2(3.0, 8.0)), 1.0);

    // 内边框：dH/dV 是离外边框内沿的距离
    float dH = top ? o.y - LINE_W : (bottom ? CELL.y - 1.0 - LINE_W - o.y : 1000.0);
    float dV = left ? o.x - LINE_W : (right ? CELL.x - 1.0 - LINE_W - o.x : 1000.0);
    bool onH = dH >= INSET && dH < INSET + INNER_W && dV >= INSET;
    bool onV = dV >= INSET && dV < INSET + INNER_W && dH >= INSET;
    if (onH || onV) fragColor = vec4(mix(fragColor.rgb, K, INNER_ALPHA), 1.0);
}
