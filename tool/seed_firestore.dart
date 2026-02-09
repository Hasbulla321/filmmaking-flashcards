import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// All flashcard data extracted from index.js.
/// Each map follows the Firestore schema: cat, title, desc, film, tryThis, icon, order.
/// The 'id' field is used as the Firestore document ID, not stored inside the document.
final List<Map<String, dynamic>> cards = [
  // ── STORY ──
  {
    'id': 's1',
    'cat': 'Story',
    'title': 'The Rashomon Effect',
    'desc':
        "Telling the same event from multiple contradictory perspectives, forcing the audience to question truth itself. Akira Kurosawa pioneered this in 'Rashomon' (1950), where four witnesses give completely different accounts of a murder.",
    'film': 'Rashomon (1950)',
    'tryThis':
        'Write a 2-minute scene of an argument told from both sides \u2014 make both versions feel completely true.',
    'icon': '\u{1F4D6}',
    'order': 1,
  },
  {
    'id': 's2',
    'cat': 'Story',
    'title': 'The Unreliable Narrator',
    'desc':
        "When the storyteller themselves cannot be trusted. The audience builds a reality only to have it shattered. David Fincher's 'Fight Club' withholds the narrator's fractured psyche until the devastating reveal.",
    'film': 'Fight Club (1999)',
    'tryThis':
        'Write a short film where the narrator confidently describes events \u2014 but visual clues tell a different story.',
    'icon': '\u{1F4D6}',
    'order': 2,
  },
  {
    'id': 's3',
    'cat': 'Story',
    'title': 'In Medias Res',
    'desc':
        "Starting the story in the middle of the action, then circling back. This hooks the audience immediately with stakes before they understand context. 'Memento' takes this to the extreme by telling its story in reverse.",
    'film': 'Memento (2000)',
    'tryThis':
        'Open your next script at the most intense moment, then slowly reveal how the character got there.',
    'icon': '\u{1F4D6}',
    'order': 3,
  },
  {
    'id': 's4',
    'cat': 'Story',
    'title': 'The MacGuffin',
    'desc':
        "An object everyone in the story wants, but its true nature is irrelevant \u2014 it exists only to drive the plot. Hitchcock mastered this: the briefcase in 'Pulp Fiction' is the perfect modern example \u2014 we never learn what's inside.",
    'film': 'Pulp Fiction (1994)',
    'tryThis':
        'Write a chase scene over an object. Never reveal what it is. See if the audience still cares.',
    'icon': '\u{1F4D6}',
    'order': 4,
  },
  {
    'id': 's5',
    'cat': 'Story',
    'title': 'Dramatic Irony',
    'desc':
        "When the audience knows something the character doesn't. This creates unbearable tension. In 'Jaws,' we see the shark approaching while swimmers are oblivious, turning a simple beach scene into pure dread.",
    'film': 'Jaws (1975)',
    'tryThis':
        "Shoot a dinner scene where we know one character has been betrayed \u2014 but they don't. Let the audience squirm.",
    'icon': '\u{1F4D6}',
    'order': 5,
  },
  {
    'id': 's6',
    'cat': 'Story',
    'title': 'The Ticking Clock',
    'desc':
        "Imposing a hard deadline on the story compresses tension exponentially. Nolan's 'Dunkirk' uses three intersecting timelines \u2014 one week, one day, one hour \u2014 each with its own countdown to survival.",
    'film': 'Dunkirk (2017)',
    'tryThis':
        'Add an explicit time limit to your next scene. Show a clock. Watch how it changes every line of dialogue.',
    'icon': '\u{1F4D6}',
    'order': 6,
  },
  {
    'id': 's7',
    'cat': 'Story',
    'title': "Show, Don't Tell",
    'desc':
        "The most fundamental rule of visual storytelling. Instead of characters explaining emotions, show them through action and image. In 'Up,' an entire love story is told without a single word of dialogue in the opening montage.",
    'film': 'Up (2009)',
    'tryThis':
        'Tell a complete emotional arc in 60 seconds with zero dialogue \u2014 only images, movement, and sound.',
    'icon': '\u{1F4D6}',
    'order': 7,
  },
  {
    'id': 's8',
    'cat': 'Story',
    'title': 'The Cold Open',
    'desc':
        "Beginning with an intense, often unrelated sequence before the title card. It sets the tone and hooks the viewer instantly. 'Inglourious Basterds' opens with a 20-minute tension masterclass before the title even appears.",
    'film': 'Inglourious Basterds (2009)',
    'tryThis':
        "Write a 3-minute cold open for a thriller that ends on a question the audience can't ignore.",
    'icon': '\u{1F4D6}',
    'order': 8,
  },

  // ── SHOT ──
  {
    'id': 'sh1',
    'cat': 'Shot',
    'title': 'The Oner (Long Take)',
    'desc':
        "An unbroken single shot that follows action continuously, immersing the viewer in real time. The opening of 'Touch of Evil' is a legendary 3-minute tracking shot that builds unbearable suspense as a car bomb ticks down.",
    'film': 'Touch of Evil (1958)',
    'tryThis':
        'Choreograph a 90-second scene in one unbroken take. Plan every movement like a dance.',
    'icon': '\u{1F3AC}',
    'order': 9,
  },
  {
    'id': 'sh2',
    'cat': 'Shot',
    'title': 'The Dolly Zoom (Vertigo Effect)',
    'desc':
        "Simultaneously zooming in while dollying out (or vice versa), creating a disorienting warp of perspective. Hitchcock invented it for 'Vertigo' to visualize the feeling of acrophobia. Spielberg used it masterfully in 'Jaws.'",
    'film': 'Vertigo (1958) / Jaws (1975)',
    'tryThis':
        'Use a dolly zoom at the exact moment a character realizes something terrible. Time it to their expression.',
    'icon': '\u{1F3AC}',
    'order': 10,
  },
  {
    'id': 'sh3',
    'cat': 'Shot',
    'title': 'The Whip Pan',
    'desc':
        "A rapid horizontal camera movement that blurs everything between two subjects, creating a jarring, energetic transition. Damien Chazelle uses whip pans in 'Whiplash' to match the frantic intensity of jazz drumming.",
    'film': 'Whiplash (2014)',
    'tryThis':
        "Use whip pans to connect two characters in an argument \u2014 let the camera's violence mirror the conflict.",
    'icon': '\u{1F3AC}',
    'order': 11,
  },
  {
    'id': 'sh4',
    'cat': 'Shot',
    'title': "The Bird's Eye View",
    'desc':
        'Shooting directly from above, making characters look small, vulnerable, or trapped. Kubrick used this obsessively to create a godlike, detached perspective that makes humans look like insects in a maze.',
    'film': 'The Shining (1980)',
    'tryThis':
        'Shoot a character walking alone from directly above. Notice how it changes the emotional weight of the scene.',
    'icon': '\u{1F3AC}',
    'order': 12,
  },
  {
    'id': 'sh5',
    'cat': 'Shot',
    'title': 'The Tracking Shot',
    'desc':
        "The camera moves alongside the subject, creating a sense of journey and momentum. Kubrick's steadicam tracking shots through the Overlook Hotel corridors created an unprecedented feeling of dread.",
    'film': 'The Shining (1980)',
    'tryThis':
        'Follow a character through three distinct spaces in one tracking shot \u2014 let the environment tell the story.',
    'icon': '\u{1F3AC}',
    'order': 13,
  },
  {
    'id': 'sh6',
    'cat': 'Shot',
    'title': 'The Dutch Angle',
    'desc':
        "Tilting the camera off its horizontal axis to create unease and disorientation. Used sparingly, it signals that something is wrong. 'The Third Man' uses it throughout to reflect the moral corruption of post-war Vienna.",
    'film': 'The Third Man (1949)',
    'tryThis':
        "Tilt your camera 15\u00B0 in a scene where a character is lying. See how it subconsciously signals deception.",
    'icon': '\u{1F3AC}',
    'order': 14,
  },
  {
    'id': 'sh7',
    'cat': 'Shot',
    'title': 'The Smash Cut',
    'desc':
        "An abrupt, jarring transition from one scene to another \u2014 often from calm to chaos or silence to noise. Used to shock the viewer. '2001: A Space Odyssey' famously smash cuts from a bone thrown in the air to a space station.",
    'film': '2001: A Space Odyssey (1968)',
    'tryThis':
        'Cut from absolute silence to the loudest moment in your film. Make the audience physically react.',
    'icon': '\u{1F3AC}',
    'order': 15,
  },

  // ── SOUND ──
  {
    'id': 'so1',
    'cat': 'Sound',
    'title': 'The Sound Bridge',
    'desc':
        "Audio from the next scene begins before the visual cut, pulling the audience forward in time. This creates seamless, almost hypnotic transitions. Coppola uses this throughout 'Apocalypse Now' to blur reality and memory.",
    'film': 'Apocalypse Now (1979)',
    'tryThis':
        'In your next edit, start the audio of scene B while still showing scene A. Notice how it smooths time.',
    'icon': '\u{1F50A}',
    'order': 16,
  },
  {
    'id': 'so2',
    'cat': 'Sound',
    'title': 'Diegetic vs. Non-Diegetic Blur',
    'desc':
        "Blurring the line between sounds that exist in the story world and the score. In 'Baby Driver,' the entire world syncs to the protagonist's music, making it impossible to tell where reality ends and soundtrack begins.",
    'film': 'Baby Driver (2017)',
    'tryThis':
        "Have a character put on headphones \u2014 transition the score into what they hear. Make the audience live inside their head.",
    'icon': '\u{1F50A}',
    'order': 17,
  },
  {
    'id': 'so3',
    'cat': 'Sound',
    'title': 'The Power of Silence',
    'desc':
        "Removing all sound at a critical moment creates more impact than any explosion. In 'No Country for Old Men,' the Coens strip away the score entirely \u2014 the silence becomes a character, amplifying every footstep and breath.",
    'film': 'No Country for Old Men (2007)',
    'tryThis':
        'Remove ALL sound for 5 seconds at the peak of a tense scene. Let the silence hit harder than any sound could.',
    'icon': '\u{1F50A}',
    'order': 18,
  },
  {
    'id': 'so4',
    'cat': 'Sound',
    'title': 'Foley Storytelling',
    'desc':
        "Using carefully crafted everyday sounds to tell the story. The crunch of gravel, the drip of water, the scratch of a pen \u2014 each sound is a narrative choice. 'A Quiet Place' made every Foley sound a matter of life and death.",
    'film': 'A Quiet Place (2018)',
    'tryThis':
        'Record a scene using ONLY Foley \u2014 no dialogue, no music. Tell the entire story through environmental sounds.',
    'icon': '\u{1F50A}',
    'order': 19,
  },
  {
    'id': 'so5',
    'cat': 'Sound',
    'title': 'Leitmotif',
    'desc':
        "A recurring musical theme tied to a character, place, or idea. When it plays, even subtly, the audience subconsciously feels that association. John Williams' Imperial March instantly evokes Darth Vader's presence, even off-screen.",
    'film': 'Star Wars: The Empire Strikes Back (1980)',
    'tryThis':
        'Compose a simple 4-note motif for your protagonist. Weave it into three different scenes with different arrangements.',
    'icon': '\u{1F50A}',
    'order': 20,
  },
  {
    'id': 'so6',
    'cat': 'Sound',
    'title': 'Contrapuntal Sound',
    'desc':
        "Pairing visuals with deliberately contrasting music to create irony, horror, or dark humor. Kubrick scored ultraviolence with classical music in 'A Clockwork Orange,' making the juxtaposition unbearable.",
    'film': 'A Clockwork Orange (1971)',
    'tryThis':
        "Score a violent or dark scene with a cheerful children's song. Feel how it multiplies the horror.",
    'icon': '\u{1F50A}',
    'order': 21,
  },

  // ── COLOR ──
  {
    'id': 'c1',
    'cat': 'Color',
    'title': 'The Orange and Teal Look',
    'desc':
        'The most dominant color grading trend in modern cinema. Warm skin tones against cool blue backgrounds create visual pop and separation. Michael Bay popularized it, but it now appears in everything from Marvel to indie dramas.',
    'film': 'Transformers (2007) / Mad Max: Fury Road (2015)',
    'tryThis':
        'Grade a scene pushing skin tones warm and shadows cool. Notice how subjects instantly pop from backgrounds.',
    'icon': '\u{1F3A8}',
    'order': 22,
  },
  {
    'id': 'c2',
    'cat': 'Color',
    'title': 'Desaturation for Realism',
    'desc':
        "Stripping color creates a documentary feel and emotional weight. Spielberg desaturated 'Saving Private Ryan' to near-monochrome, making the violence feel historical and uncomfortably real.",
    'film': 'Saving Private Ryan (1998)',
    'tryThis':
        "Take a colorful scene and progressively desaturate it. Find the exact point where it shifts from 'pretty' to 'real.'",
    'icon': '\u{1F3A8}',
    'order': 23,
  },
  {
    'id': 'c3',
    'cat': 'Color',
    'title': 'Color as Character Arc',
    'desc':
        "Using color palette shifts to mirror a character's journey. In 'Breaking Bad,' Walter White's wardrobe shifts from beige to black as he transforms from teacher to kingpin \u2014 every color choice is deliberate.",
    'film': 'Breaking Bad (2008\u20132013)',
    'tryThis':
        'Plan a character\'s wardrobe across three scenes: start neutral, shift to a bold color as they transform.',
    'icon': '\u{1F3A8}',
    'order': 24,
  },
  {
    'id': 'c4',
    'cat': 'Color',
    'title': 'The Monochromatic Palette',
    'desc':
        "Restricting the frame to variations of a single color creates a hypnotic, dreamlike quality. 'The Grand Budapest Hotel' uses precise pastel pinks to build an entire world that feels like a fading postcard.",
    'film': 'The Grand Budapest Hotel (2014)',
    'tryThis':
        'Limit your next scene to one dominant color. Dress the set, wardrobe, and grade everything to match.',
    'icon': '\u{1F3A8}',
    'order': 25,
  },
  {
    'id': 'c5',
    'cat': 'Color',
    'title': 'Complementary Color Tension',
    'desc':
        'Placing complementary colors (opposites on the color wheel) in the same frame creates visual tension and energy. Wes Anderson and Zhang Yimou use red and green, or gold and blue, to create frames that vibrate with life.',
    'film': 'Hero (2002)',
    'tryThis':
        'Design a frame using only two complementary colors. Remove everything else. See how it focuses the eye.',
    'icon': '\u{1F3A8}',
    'order': 26,
  },

  // ── LENS ──
  {
    'id': 'l1',
    'cat': 'Lens',
    'title': 'Wide Angle Distortion',
    'desc':
        "Wide lenses (below 24mm) exaggerate depth and distort edges, making close objects loom large and distant ones feel far away. Deakins used wide angles in 'No Country for Old Men' to emphasize the vast, empty Texas landscape as a character.",
    'film': 'No Country for Old Men (2007)',
    'tryThis':
        'Shoot a portrait at 16mm from very close. Notice how it distorts features and creates unease.',
    'icon': '\u{1F52D}',
    'order': 27,
  },
  {
    'id': 'l2',
    'cat': 'Lens',
    'title': 'Shallow Depth of Field',
    'desc':
        "Using a wide aperture to blur everything except the subject, isolating them from the world. This creates intimacy and directs the viewer's eye precisely. Wong Kar-wai uses it to make his characters feel romantically adrift.",
    'film': 'In the Mood for Love (2000)',
    'tryThis':
        'Shoot at the widest aperture your lens allows. Rack focus between two characters to shift power in a conversation.',
    'icon': '\u{1F52D}',
    'order': 28,
  },
  {
    'id': 'l3',
    'cat': 'Lens',
    'title': 'Anamorphic Lens Flares',
    'desc':
        "Anamorphic lenses create horizontal blue streaks when light hits the glass, adding a cinematic, almost ethereal quality. J.J. Abrams pushed this to the extreme in 'Star Trek,' using flares as a stylistic signature.",
    'film': 'Star Trek (2009) / Blade Runner 2049 (2017)',
    'tryThis':
        'Shine a light source just off-frame into an anamorphic or vintage lens. Let the flare become part of the composition.',
    'icon': '\u{1F52D}',
    'order': 29,
  },
  {
    'id': 'l4',
    'cat': 'Lens',
    'title': 'The Long Lens Compression',
    'desc':
        'Telephoto lenses (85mm+) compress depth, stacking elements flat and making distant objects appear closer. This creates claustrophobia and tension. Kurosawa used long lenses to flatten samurai battles into painterly compositions.',
    'film': 'Ran (1985)',
    'tryThis':
        'Shoot two people talking from far away with a 200mm lens. Notice how the flattened space changes their relationship.',
    'icon': '\u{1F52D}',
    'order': 30,
  },
  {
    'id': 'l5',
    'cat': 'Lens',
    'title': 'The Macro Lens World',
    'desc':
        "Extreme close-up lenses reveal a hidden universe in tiny details \u2014 the texture of skin, the surface of water, the mechanics of a watch. Terrence Malick uses macro shots to find cosmic beauty in the smallest things.",
    'film': 'The Tree of Life (2011)',
    'tryThis':
        'Shoot 10 macro shots of everyday objects. Find the one that looks like it could be a planet or a painting.',
    'icon': '\u{1F52D}',
    'order': 31,
  },

  // ── FRAMING ──
  {
    'id': 'f1',
    'cat': 'Framing',
    'title': 'The Frame Within a Frame',
    'desc':
        'Using doors, windows, mirrors, or architectural elements to create a second frame inside the camera\'s frame. This adds depth and can trap or isolate characters. Kubrick used doorways obsessively to create frames within frames.',
    'film': 'Barry Lyndon (1975)',
    'tryThis':
        'Compose every shot in a scene through doorways, windows, or arches. Never show a character in open space.',
    'icon': '\u{1F4D0}',
    'order': 32,
  },
  {
    'id': 'f2',
    'cat': 'Framing',
    'title': 'Negative Space',
    'desc':
        "Leaving large empty areas in the frame to create loneliness, vulnerability, or anticipation. The emptiness itself becomes a storytelling tool. 'Lost in Translation' uses vast empty hotel rooms to visualize emotional isolation.",
    'film': 'Lost in Translation (2003)',
    'tryThis':
        'Place your character in the bottom corner of a wide frame. Leave 70% of the frame empty. Feel the loneliness.',
    'icon': '\u{1F4D0}',
    'order': 33,
  },
  {
    'id': 'f3',
    'cat': 'Framing',
    'title': 'Symmetrical Composition',
    'desc':
        "Perfectly centered, symmetrical frames create a sense of order, control, or obsession. Wes Anderson made this his signature \u2014 every frame is a precisely balanced dollhouse of visual information.",
    'film': 'The Grand Budapest Hotel (2014)',
    'tryThis':
        'Compose a scene with perfect symmetry. Then break it with one asymmetrical element. Notice what draws the eye.',
    'icon': '\u{1F4D0}',
    'order': 34,
  },
  {
    'id': 'f4',
    'cat': 'Framing',
    'title': 'The Over-the-Shoulder Shot',
    'desc':
        "Framing a conversation with one character's shoulder in the foreground creates intimacy and spatial relationship. Varying the size of the shoulder can shift power dynamics \u2014 a larger shoulder makes that character feel dominant.",
    'film': 'The Social Network (2010)',
    'tryThis':
        "In a dialogue scene, make one character's shoulder progressively larger in the frame as they gain power in the argument.",
    'icon': '\u{1F4D0}',
    'order': 35,
  },
  {
    'id': 'f5',
    'cat': 'Framing',
    'title': 'Leading Lines',
    'desc':
        "Using natural lines in the environment \u2014 roads, corridors, fences, shadows \u2014 to guide the viewer's eye toward the subject. This creates depth and visual flow. Kubrick's hallways are legendary examples of one-point perspective.",
    'film': 'The Shining (1980)',
    'tryThis':
        'Find a corridor, road, or fence line. Place your subject at the vanishing point. Let the lines pull the viewer in.',
    'icon': '\u{1F4D0}',
    'order': 36,
  },
  {
    'id': 'f6',
    'cat': 'Framing',
    'title': 'Headroom as Emotion',
    'desc':
        "The space above a character's head in the frame communicates their emotional state. Too much headroom makes them feel small and overwhelmed. Too little makes them feel trapped. Intentional headroom choices are a subtle but powerful tool.",
    'film': 'Mr. Robot (2015\u20132019)',
    'tryThis':
        'Shoot the same dialogue twice: once with excessive headroom, once with almost none. Compare the emotional impact.',
    'icon': '\u{1F4D0}',
    'order': 37,
  },

  // ── BLOCKING ──
  {
    'id': 'b1',
    'cat': 'Blocking',
    'title': 'The Power Triangle',
    'desc':
        "Positioning three characters in a triangle within the frame creates dynamic tension and hierarchy. The character at the apex holds the power. Spielberg frequently stages group scenes this way to guide the audience's eye.",
    'film': "Schindler's List (1993)",
    'tryThis':
        "Stage a three-person scene. Move the 'powerful' character to the triangle's apex. Watch how attention shifts.",
    'icon': '\u{1F3AD}',
    'order': 38,
  },
  {
    'id': 'b2',
    'cat': 'Blocking',
    'title': 'Proxemics in Film',
    'desc':
        'The physical distance between characters communicates their relationship. Intimate (under 18 inches), personal, social, and public distances each tell a different story. Manipulating this distance IS the performance direction.',
    'film': 'Marriage Story (2019)',
    'tryThis':
        'Start two characters far apart. Over the scene, bring them inches apart \u2014 or push them further away. Let distance speak.',
    'icon': '\u{1F3AD}',
    'order': 39,
  },
  {
    'id': 'b3',
    'cat': 'Blocking',
    'title': 'The Walk and Talk',
    'desc':
        "Characters walking while talking adds energy, forward momentum, and naturalism. Aaron Sorkin made this his signature in 'The West Wing.' The movement makes exposition feel urgent instead of static.",
    'film': 'The West Wing (1999\u20132006)',
    'tryThis':
        'Restage a sitting dialogue scene as a walk-and-talk. Notice how the energy and pacing transform completely.',
    'icon': '\u{1F3AD}',
    'order': 40,
  },
  {
    'id': 'b4',
    'cat': 'Blocking',
    'title': 'Levels and Height',
    'desc':
        'Placing characters at different physical heights within a scene \u2014 standing vs. sitting, stairs, elevated platforms \u2014 creates instant visual power dynamics without a word being spoken.',
    'film': 'The Godfather (1972)',
    'tryThis':
        'In a two-person scene, have one character stand while the other sits. Halfway through, reverse it. Feel the power shift.',
    'icon': '\u{1F3AD}',
    'order': 41,
  },
  {
    'id': 'b5',
    'cat': 'Blocking',
    'title': 'The Reveal Through Movement',
    'desc':
        'Using character or camera movement to reveal something hidden in the frame. A character steps aside to reveal another person, or the camera pans to uncover a crucial detail. The movement IS the storytelling.',
    'film': 'Se7en (1995)',
    'tryThis':
        'Hide a key story element behind a character. Reveal it only when they move. Time it to maximum impact.',
    'icon': '\u{1F3AD}',
    'order': 42,
  },

  // ── VFX ──
  {
    'id': 'v1',
    'cat': 'VFX',
    'title': 'Invisible VFX',
    'desc':
        "The best visual effects are the ones you never notice. 'Zodiac' used extensive CGI to recreate 1970s San Francisco \u2014 audiences assumed it was all practical. The goal is seamlessness, not spectacle.",
    'film': 'Zodiac (2007)',
    'tryThis':
        'Watch a drama you assumed was VFX-free. Search for its VFX breakdown. Prepare to be shocked.',
    'icon': '\u2728',
    'order': 43,
  },
  {
    'id': 'v2',
    'cat': 'VFX',
    'title': 'Forced Perspective',
    'desc':
        'A practical, in-camera effect that uses distance and scale to make objects appear larger or smaller than they are. Peter Jackson used this brilliantly to make hobbits appear small next to humans \u2014 no CGI needed.',
    'film': 'The Lord of the Rings (2001\u20132003)',
    'tryThis':
        'Place a small object close to the lens and a person far away. Align them in frame to create an impossible scale.',
    'icon': '\u2728',
    'order': 44,
  },
  {
    'id': 'v3',
    'cat': 'VFX',
    'title': 'The Digital De-Age',
    'desc':
        "Using AI and CGI to make actors appear decades younger. Scorsese used it throughout 'The Irishman' to span decades with the same actors, sparking debate about the uncanny valley.",
    'film': 'The Irishman (2019)',
    'tryThis':
        'Study how light falls on faces at different ages. The key difference is often skin translucency and micro-shadows.',
    'icon': '\u2728',
    'order': 45,
  },
  {
    'id': 'v4',
    'cat': 'VFX',
    'title': 'Miniature Photography',
    'desc':
        "Building detailed physical models and filming them to look full-scale. Before CGI, this was how entire worlds were built. Ridley Scott's 'Blade Runner' cityscapes were intricate miniatures shot with smoke and light.",
    'film': 'Blade Runner (1982)',
    'tryThis':
        'Build a simple miniature set from cardboard and household items. Shoot it with shallow depth of field and dramatic lighting.',
    'icon': '\u2728',
    'order': 46,
  },

  // ── HISTORY ──
  {
    'id': 'h1',
    'cat': 'History',
    'title': 'The 300 Spartans at Thermopylae',
    'desc':
        "In 480 BC, 300 Spartan warriors held a narrow coastal pass against an estimated 100,000\u2013300,000 Persian soldiers for three days. King Leonidas knew it was a suicide mission, but their sacrifice bought Greece the time it needed to survive. Their stand became the ultimate symbol of courage against impossible odds.",
    'film': '300 (2006)',
    'tryThis':
        'Write a scene where a character knowingly walks into a fight they cannot win \u2014 make us understand why they do it anyway.',
    'icon': '\u2694\uFE0F',
    'order': 47,
  },
  {
    'id': 'h2',
    'cat': 'History',
    'title': 'The Sinking of the Titanic',
    'desc':
        "On April 15, 1912, the 'unsinkable' Titanic struck an iceberg and went down in 2 hours and 40 minutes. The band played as the ship sank. Wealthy men gave up lifeboat seats. Couples chose to die together rather than separate. 1,517 people perished in the freezing Atlantic.",
    'film': 'Titanic (1997)',
    'tryThis':
        'Write a scene set in the final 10 minutes before a disaster. Focus on two strangers who must decide: save themselves or help someone else.',
    'icon': '\u2694\uFE0F',
    'order': 48,
  },
  {
    'id': 'h3',
    'cat': 'History',
    'title': 'The Speech That Saved Britain',
    'desc':
        "In June 1940, with France falling and Britain standing alone against Nazi Germany, Winston Churchill delivered 'We shall fight on the beaches.' He offered nothing but 'blood, toil, tears, and sweat.' His words transformed a terrified nation into one that refused to surrender.",
    'film': 'Darkest Hour (2017)',
    'tryThis':
        'Write a speech for a leader who has no good news \u2014 only the truth and a reason to keep fighting.',
    'icon': '\u2694\uFE0F',
    'order': 49,
  },
  {
    'id': 'h4',
    'cat': 'History',
    'title': 'The Moonshot',
    'desc':
        "On July 20, 1969, Neil Armstrong and Buzz Aldrin walked on the Moon while Michael Collins orbited alone above. The entire mission ran on less computing power than a modern calculator. 600 million people watched live. It remains humanity's greatest 'we actually did it' moment.",
    'film': 'First Man (2018)',
    'tryThis':
        "Write a scene about the loneliest person in a triumphant moment \u2014 the one left behind while others celebrate.",
    'icon': '\u2694\uFE0F',
    'order': 50,
  },
  {
    'id': 'h5',
    'cat': 'History',
    'title': 'The Escape from Alcatraz',
    'desc':
        'In June 1962, Frank Morris and the Anglin brothers escaped the inescapable Alcatraz prison using sharpened spoons, raincoats turned into a raft, and fake heads made of soap and hair to fool guards. They were never found \u2014 dead or alive.',
    'film': 'Escape from Alcatraz (1979)',
    'tryThis':
        'Write a heist or escape scene where the plan relies on one absurdly simple, overlooked detail.',
    'icon': '\u2694\uFE0F',
    'order': 51,
  },
  {
    'id': 'h6',
    'cat': 'History',
    'title': 'The Christmas Truce of 1914',
    'desc':
        "On Christmas Eve 1914, German and British soldiers in the trenches of WWI spontaneously stopped fighting. They sang carols, shared cigarettes, and played football in no man's land. The next day, they went back to killing each other. It never happened again at that scale.",
    'film': 'Joyeux No\u00EBl (2005)',
    'tryThis':
        'Write a scene where two enemies share one genuine human moment \u2014 then must return to being enemies.',
    'icon': '\u2694\uFE0F',
    'order': 52,
  },
  {
    'id': 'h7',
    'cat': 'History',
    'title': 'The Chernobyl Divers',
    'desc':
        'In 1986, three engineers \u2014 Alexei Ananenko, Valeri Bezpalov, and Boris Baranov \u2014 volunteered to wade through radioactive water beneath the melting Chernobyl reactor to open drainage valves. If they failed, a steam explosion could have made much of Europe uninhabitable. They succeeded.',
    'film': 'Chernobyl (2019)',
    'tryThis':
        'Write a scene where a character volunteers for something no one should survive. Focus on the quiet moment before they go.',
    'icon': '\u2694\uFE0F',
    'order': 53,
  },
  {
    'id': 'h8',
    'cat': 'History',
    'title': 'The Fall of the Berlin Wall',
    'desc':
        'On November 9, 1989, a confused press conference accidentally announced that East Germans could cross freely. Thousands rushed to the wall. Border guards, overwhelmed and without orders, simply opened the gates. Families separated for 28 years embraced in the streets.',
    'film': 'The Lives of Others (2006)',
    'tryThis':
        'Write a scene where a massive historical change happens because of one small human error \u2014 and it turns out to be beautiful.',
    'icon': '\u2694\uFE0F',
    'order': 54,
  },
  {
    'id': 'h9',
    'cat': 'History',
    'title': "Shackleton's Endurance Expedition",
    'desc':
        "In 1915, Ernest Shackleton's ship 'Endurance' was crushed by Antarctic ice, stranding 27 men. Over 2 years, Shackleton kept every single person alive through starvation, frozen oceans, and an 800-mile open-boat journey across the most dangerous seas on Earth. Not one man died.",
    'film': 'The Endurance (2000)',
    'tryThis':
        "Write a survival story where the leader's only weapon is the ability to keep people believing they'll make it.",
    'icon': '\u2694\uFE0F',
    'order': 55,
  },
  {
    'id': 'h10',
    'cat': 'History',
    'title': "The Samurai's Last Stand",
    'desc':
        "In 1877, Saig\u014D Takamori led the last samurai rebellion against Japan's modernizing army. Armed with swords against cannons and Gatling guns, they fought knowing their era was over. Saig\u014D died on the battlefield, becoming a legend \u2014 the embodiment of honor in a world that had moved on.",
    'film': 'The Last Samurai (2003)',
    'tryThis':
        "Write a scene where a character fights for something they know is already lost \u2014 not to win, but because it's who they are.",
    'icon': '\u2694\uFE0F',
    'order': 56,
  },
];

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  // Firestore batch writes are limited to 500 operations per batch.
  // With 56 cards we only need a single batch, but we chunk defensively.
  const batchLimit = 500;
  var batch = firestore.batch();
  var opsInBatch = 0;

  for (final card in cards) {
    final docId = card['id'] as String;

    // Build the document data (everything except 'id', which becomes the doc ID).
    final data = <String, dynamic>{
      'cat': card['cat'],
      'title': card['title'],
      'desc': card['desc'],
      'film': card['film'],
      'tryThis': card['tryThis'],
      'icon': card['icon'],
      'order': card['order'],
    };

    final docRef = firestore.collection('flashcards').doc(docId);
    batch.set(docRef, data);
    opsInBatch++;

    // Commit and start a new batch if we hit the limit.
    if (opsInBatch >= batchLimit) {
      await batch.commit();
      print('Committed batch of $opsInBatch documents.');
      batch = firestore.batch();
      opsInBatch = 0;
    }
  }

  // Commit any remaining operations.
  if (opsInBatch > 0) {
    await batch.commit();
    print('Committed final batch of $opsInBatch documents.');
  }

  print('Successfully seeded ${cards.length} flashcards to Firestore.');
}
