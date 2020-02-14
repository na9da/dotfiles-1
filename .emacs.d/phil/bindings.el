(global-set-key (kbd "C-c f") 'project-find-file)

(add-hook 'prog-mode-hook
          (defun my-kill-word-key ()
            (local-set-key (kbd "C-M-h") 'backward-kill-word)))

(global-set-key (kbd "C-M-h") 'backward-kill-word)

(global-set-key (kbd "C-x C-i") 'imenu)

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2)))

(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x C-m") 'shell)

(global-set-key (kbd "C-c q") 'join-line)
(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key (kbd "C-c n")
                (defun pnh-cleanup-buffer () (interactive)
                       (delete-trailing-whitespace)
                       (untabify (point-min) (point-max))
                       (indent-region (point-min) (point-max))))

(global-set-key (kbd "C-c b") 'browse-url-at-point)

(global-set-key (kbd "C-c w") 'winner-undo)

(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

;; atreus dvorak bindings
(global-set-key (kbd "C-x '") 'delete-other-windows)
(global-set-key (kbd "C-x ,") 'split-window-below)
(global-set-key (kbd "C-x .") 'split-window-right)
(global-set-key (kbd "C-x l") 'delete-window)

;; bios handles this but also passes it thru?
(global-set-key (kbd "<XF86MonBrightnessDown>") 'ignore)
(global-set-key (kbd "<XF86MonBrightnessUp>") 'ignore)

(defun pnh-music-read ()
  (interactive)
  (let* ((lines (with-temp-buffer
                  (insert-file "~/music/.dirs")
                  (buffer-substring-no-properties 1 (point-max))))
         (dirs (split-string lines "\n")))
    (ido-completing-read "Play: " dirs nil t)))

(defun pnh-music-choose ()
  (interactive)
  (save-window-excursion
    (start-process-shell-command "*mpc*" nil
                                 (format "mpc clear; mpc add %s; mpc play"
                                         (pnh-music-read)))))

(global-set-key (kbd "<f7>") 'pnh-music-choose)

(global-set-key (kbd "M-<f12>")
                (defun pnh-time ()
                  (interactive)
                  (let ((fmt "%Y-%m-%d %H:%M:%S"))
                    (message (concat (format-time-string fmt nil t)
                                     " / " (format-time-string fmt))))))

(defun pnh-gifs-refresh ()
  (interactive)
  (let ((files (cdr (cdr (directory-files pnh-gifs-dir)))))
    (insert (format "(defvar pnh-gifs '%S)" files))))

(defvar pnh-gifs '("10good.gif" "10hair.gif" "10no.gif" "10oh.gif" "10sad.gif" "11-something.gif" "11what.gif" "127.gif" "12smile.gif" "367deal.gif" "4grin.gif" "4lights.jpg" "9grin.gif" "9no.gif" "absolutely.gif" "allison.jpg" "alternate.gif" "always.jpg" "anime.png" "antipathy.jpg" "arrowed.jpg" "automated.png" "awesome.gif" "bashir-drink.gif" "bashir-gift.gif" "bashir.gif" "beard-nod.gif" "beetface.jpg" "blam.gif" "boatcomputing.jpg" "boot-up.gif" "brunt.gif" "burnham.gif" "called-me-bro.jpg" "candle.gif" "canna-take.jpg" "car.jpg" "catalog.jpg" "chair.gif" "change.gif" "chewing.gif" "chowyunfat.gif" "chuckle.gif" "clap.gif" "clicking.png" "clojure-docstrings.jpg" "colorful-metaphor.jpg" "comfort.jpg" "compiler.jpg" "complect.jpg" "complicated.jpg" "connection-terminated.gif" "console-cowboys.gif" "context.gif" "cool-story-bro.jpg" "cool.gif" "coolmom.gif" "correct-answer.gif" "countdown.gif" "coupon-dance.png" "crusher.gif" "cs.gif" "csb.gif" "csp.jpg" "damage-report.jpg" "damn.gif" "data-frank.gif" "data-friends.gif" "data-no.gif" "data-understatement.gif" "data.gif" "dax.gif" "defer.gif" "denied.gif" "desk.jpg" "desperate.jpg" "differences.jpg" "dignity.gif" "disagree.jpg" "disappointed.gif" "dishonor.gif" "do-it.gif" "dont.jpg" "dontcare.gif" "dozens.gif" "drown-less.jpg" "drracket-error.png" "ds9.gif" "duck-hand.png" "dukat-charm.gif" "dukat.gif" "e-note.jpg" "electronic-mail.jpg" "erlangs.jpg" "esr.jpg" "every-tweet.jpg" "everything-is-fine.jpg" "exceptions.gif" "exciting.gif" "exist-as.png" "explain.gif" "explain.jpg" "eyebrow.gif" "ezri.gif" "fake.gif" "fantastic.gif" "fascinating.jpg" "fault-tolerance.png" "favicon.gif" "feynman.jpg" "finch.jpg" "fine.gif" "fire.gif" "forth.png" "found.gif" "fried.gif" "fun.mp4" "funding.png" "future.jpg" "garak-dont-know.gif" "garak-no.gif" "garak-perfect.gif" "garak-seconds.gif" "garak-shake.gif" "garak-thank-you.gif" "garak-worthwhile.gif" "garashir.gif" "geordi-circle.gif" "geordi.gif" "gerry.jpg" "get-out.gif" "gfy.gif" "glance.gif" "go.gif" "go_fine.jpeg" "gowron.gif" "great-tragedy.gif" "greetings-programs.jpg" "groovy.gif" "guards.jpg" "hack-the-planet.gif" "hacker.mp4" "hackerman.gif" "hackers-dance.gif" "hacking-time.gif" "hammock.jpg" "heard-of-me.gif" "hello-computer.gif" "hello-joe.gif" "how-dare-you.gif" "how-delightful.gif" "hubs.png" "hyped.gif" "i-dont-believe-so.gif" "i-need-a-computer.gif" "ibm-pc.png" "infinite-sadness.jpg" "instincts.gif" "intensifies.gif" "intermediate.png" "irc.jpg" "it-must-be-destroyed.gif" "its-working.gif" "iwill.png" "janeway.gif" "janeway2.gif" "janeway3.gif" "janeway4.gif" "janeway5.gif" "janeway6.gif" "khan.gif" "kids.gif" "kim.gif" "kira.gif" "kirk-later.gif" "kirk-noise.gif" "kitty.gif" "labyrinth-man.png" "labyrinth.jpg" "leiningen.png" "lemmings.gif" "lies.gif" "life-finds-a-way.gif" "line.jpg" "logical.jpg" "lolbutts.png" "lulz.jpg" "macguyver.gif" "magic.gif" "make-it-sew.png" "mal.gif" "marry.gif" "marty.gif" "massive-props.jpg" "math-checks-out.jpg" "maven.jpg" "mech.gif" "merde.gif" "mickey.gif" "mono.gif" "morn-nod.gif" "morn-shrug.gif" "mrfp.gif" "mystery.gif" "naughty.gif" "neat.jpg" "net-work.jpg" "no-it-isnt.gif" "no-law.mp4" "no-one-to-stop-us.gif" "nofun.jpg" "nope-badger.gif" "nope.gif" "notes.jpg" "nudge.gif" "odo.gif" "oh-no.png" "oh-yeah.gif" "oh-yes.gif" "oh-you.jpg" "older-meme.gif" "online.jpg" "opinion.jpg" "otp.png" "outrage.jpg" "pay-attention.gif" "pay.png" "perhaps.gif" "pewpewpew.gif" "pharaoh.jpg" "philippe-hugs.jpg" "picard-hat.gif" "picard-nothing.gif" "picard-pleases.gif" "pike.gif" "pinisi.jpg" "pints.gif" "plan.gif" "plan.jpg" "plonking.jpg" "pod-bay-doors.gif" "pod.jpg" "post.png" "power.gif" "powerpoint.gif" "pr.png" "problem.png" "property.png" "pulaski.gif" "punch.png" "q-boo.gif" "q-booyah.gif" "q-interesting.gif" "q-nothing.gif" "q.gif" "quark-dont-bother.gif" "quark-why.gif" "quark.gif" "raccoons.jpg" "ram-gone.jpg" "rash.mp4" "reference.jpg" "rejoicing.gif" "repro.gif" "revolting.gif" "riak.jpg" "riker-fall.gif" "riker-no.gif" "riker-thank-you.gif" "riker.gif" "riker2.gif" "riker3.gif" "rms.jpg" "rom.gif" "roy.jpg" "s-video.jpg" "scala.jpg" "scared.gif" "science.gif" "science.jpg" "science.png" "scott-everything.gif" "scott-peep.png" "scott-pout.png" "scott.gif" "scott.jpg" "scruffy.jpg" "scsb.png" "serious-business.jpg" "seven.gif" "sg-they.jpg" "shake.gif" "shiny.gif" "shoo.gif" "shrug.mp4" "shutdown-agents.jpg" "sisko-beam.gif" "sisko-punch.gif" "sisko-thank-you.gif" "sisko.gif" "smart.gif" "smooth-rap-attack.png" "so-be-it.mp4" "sound-of.gif" "spaceship.webp" "spock-basically.gif" "spock-illogical.gif" "spock-klingons.gif" "spock-no.gif" "spock-out.gif" "spock-science.gif" "spock-stop.gif" "spock-yes.gif" "spock.gif" "srsbsns.png" "stamets-cool.gif" "static.jpg" "stolen-pony.jpg" "storming-the-castle.gif" "survival-trait.gif" "syllabics.jpg" "tastes-mature.png" "this-is-fine.jpg" "tilly-cool.gif" "to-the-googles.gif" "too-convenient.gif" "toxin.png" "tpol-get-out.gif" "tradition.jpg" "train-hat.jpg" "tribbles.gif" "tricorder.gif" "troop.jpg" "truck.gif" "tucker.gif" "tuvix.gif" "tuvok.gif" "two-timing.gif" "type.gif" "typing.gif" "um.gif" "unix.jpg" "update.jpg" "waiting.mp4" "warp-speed.gif" "ways.png" "well-done-computer.gif" "wfm.gif" "what-a-piece-of-junk.gif" "what.gif" "witchcraft.gif" "woody.gif" "worf-batleth.jpg" "worf-better.gif" "worf-death.gif" "worf-die.gif" "worf-drink.gif" "worf-fun.gif" "worf-good.gif" "worf-hat.gif" "worf-lies.gif" "worf-merry.gif" "worf-nerds.gif" "worf-no.gif" "worf-other.gif" "worf-outsiders.gif" "worf-tea.gif" "worf.gif" "wwpd.gif" "xena.gif"))

(defvar pnh-gifs-dir "~/docs/images/p")

(global-set-key (kbd "C-c t")
                (defun pnh-gif (insert?)
                  (interactive "P")
                  (let* ((gifs (if (file-exists-p pnh-gifs-dir)
                                   (directory-files pnh-gifs-dir)
                                 pnh-gifs))
                         (url (format "https://p.hagelb.org/%s"
                                      (ido-completing-read "gif: " gifs))))
                    (kill-new url)
                    (when insert?
                      (insert url)))))
