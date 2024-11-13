(define (custom-adjustments img layer)
  (let* (
          ;; Kontraszt növelése 3-mal
          (contrast 3)
          ;; Fényerő növelése 4-gyel
          (brightness 4)
          ;; Szaturáció csökkentése 6-tal
          (saturation -6)
          ;; Színhőmérséklet növelése 400-al
          (temperature 400)
          ;; Élesség növelése 0.1-es erősséggel
          (sharpness-amount 0.1)
        )

    ;; Aktiváljuk a képet és a réteget
    (gimp-image-undo-group-start img)

    ;; Kontraszt és fényerő növelése
    (gimp-brightness-contrast layer brightness contrast)

    ;; Szaturáció módosítása
    (gimp-hue-saturation layer 0 0 saturation 0)

    ;; Színhőmérséklet növelése
    ;; Hőmérséklet módosítása a piros és kék csatornák segítségével
    (gimp-color-balance layer 0 1 (* temperature 0.002) 0 (- (* temperature 0.002)))  ;; Árnyékok
    (gimp-color-balance layer 1 1 (* temperature 0.002) 0 (- (* temperature 0.002)))  ;; Középtónusok
    (gimp-color-balance layer 2 1 (* temperature 0.002) 0 (- (* temperature 0.002)))  ;; Fényes részek

    ;; Élesség növelése Unsharp Mask-kal
    ;; Paraméterek: (kép, réteg, sugár, mennyiség, küszöb)
    (plug-in-unsharp-mask RUN-NONINTERACTIVE img layer 5 sharpness-amount 0)

    (gimp-image-undo-group-end img)
    (gimp-displays-flush)
  )
)

(script-fu-register
 "custom-adjustments"
 "Make Me More Attractive"
 "Adjust contrast, brightness, saturation, temperature, and sharpness"
 "FMisi"
 "FMisi"
 "2024"
 "RGB*, GRAY*"
 SF-IMAGE "Image" 0
 SF-DRAWABLE "Drawable" 0
)

(script-fu-menu-register "custom-adjustments" "<Image>/Filters/Make Me More Attractive")
