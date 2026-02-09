import { useState, useEffect, useCallback, useRef } from "react";

const CARDS = [
  // STORY
  { id: "s1", cat: "Story", title: "The Rashomon Effect", desc: "Telling the same event from multiple contradictory perspectives, forcing the audience to question truth itself. Akira Kurosawa pioneered this in 'Rashomon' (1950), where four witnesses give completely different accounts of a murder.", film: "Rashomon (1950)", tryThis: "Write a 2-minute scene of an argument told from both sides — make both versions feel completely true.", icon: "📖" },
  { id: "s2", cat: "Story", title: "The Unreliable Narrator", desc: "When the storyteller themselves cannot be trusted. The audience builds a reality only to have it shattered. David Fincher's 'Fight Club' withholds the narrator's fractured psyche until the devastating reveal.", film: "Fight Club (1999)", tryThis: "Write a short film where the narrator confidently describes events — but visual clues tell a different story.", icon: "📖" },
  { id: "s3", cat: "Story", title: "In Medias Res", desc: "Starting the story in the middle of the action, then circling back. This hooks the audience immediately with stakes before they understand context. 'Memento' takes this to the extreme by telling its story in reverse.", film: "Memento (2000)", tryThis: "Open your next script at the most intense moment, then slowly reveal how the character got there.", icon: "📖" },
  { id: "s4", cat: "Story", title: "The MacGuffin", desc: "An object everyone in the story wants, but its true nature is irrelevant — it exists only to drive the plot. Hitchcock mastered this: the briefcase in 'Pulp Fiction' is the perfect modern example — we never learn what's inside.", film: "Pulp Fiction (1994)", tryThis: "Write a chase scene over an object. Never reveal what it is. See if the audience still cares.", icon: "📖" },
  { id: "s5", cat: "Story", title: "Dramatic Irony", desc: "When the audience knows something the character doesn't. This creates unbearable tension. In 'Jaws,' we see the shark approaching while swimmers are oblivious, turning a simple beach scene into pure dread.", film: "Jaws (1975)", tryThis: "Shoot a dinner scene where we know one character has been betrayed — but they don't. Let the audience squirm.", icon: "📖" },
  { id: "s6", cat: "Story", title: "The Ticking Clock", desc: "Imposing a hard deadline on the story compresses tension exponentially. Nolan's 'Dunkirk' uses three intersecting timelines — one week, one day, one hour — each with its own countdown to survival.", film: "Dunkirk (2017)", tryThis: "Add an explicit time limit to your next scene. Show a clock. Watch how it changes every line of dialogue.", icon: "📖" },
  { id: "s7", cat: "Story", title: "Show, Don't Tell", desc: "The most fundamental rule of visual storytelling. Instead of characters explaining emotions, show them through action and image. In 'Up,' an entire love story is told without a single word of dialogue in the opening montage.", film: "Up (2009)", tryThis: "Tell a complete emotional arc in 60 seconds with zero dialogue — only images, movement, and sound.", icon: "📖" },
  { id: "s8", cat: "Story", title: "The Cold Open", desc: "Beginning with an intense, often unrelated sequence before the title card. It sets the tone and hooks the viewer instantly. 'Inglourious Basterds' opens with a 20-minute tension masterclass before the title even appears.", film: "Inglourious Basterds (2009)", tryThis: "Write a 3-minute cold open for a thriller that ends on a question the audience can't ignore.", icon: "📖" },

  // SHOT
  { id: "sh1", cat: "Shot", title: "The Oner (Long Take)", desc: "An unbroken single shot that follows action continuously, immersing the viewer in real time. The opening of 'Touch of Evil' is a legendary 3-minute tracking shot that builds unbearable suspense as a car bomb ticks down.", film: "Touch of Evil (1958)", tryThis: "Choreograph a 90-second scene in one unbroken take. Plan every movement like a dance.", icon: "🎬" },
  { id: "sh2", cat: "Shot", title: "The Dolly Zoom (Vertigo Effect)", desc: "Simultaneously zooming in while dollying out (or vice versa), creating a disorienting warp of perspective. Hitchcock invented it for 'Vertigo' to visualize the feeling of acrophobia. Spielberg used it masterfully in 'Jaws.'", film: "Vertigo (1958) / Jaws (1975)", tryThis: "Use a dolly zoom at the exact moment a character realizes something terrible. Time it to their expression.", icon: "🎬" },
  { id: "sh3", cat: "Shot", title: "The Whip Pan", desc: "A rapid horizontal camera movement that blurs everything between two subjects, creating a jarring, energetic transition. Damien Chazelle uses whip pans in 'Whiplash' to match the frantic intensity of jazz drumming.", film: "Whiplash (2014)", tryThis: "Use whip pans to connect two characters in an argument — let the camera's violence mirror the conflict.", icon: "🎬" },
  { id: "sh4", cat: "Shot", title: "The Bird's Eye View", desc: "Shooting directly from above, making characters look small, vulnerable, or trapped. Kubrick used this obsessively to create a godlike, detached perspective that makes humans look like insects in a maze.", film: "The Shining (1980)", tryThis: "Shoot a character walking alone from directly above. Notice how it changes the emotional weight of the scene.", icon: "🎬" },
  { id: "sh5", cat: "Shot", title: "The Tracking Shot", desc: "The camera moves alongside the subject, creating a sense of journey and momentum. Kubrick's steadicam tracking shots through the Overlook Hotel corridors created an unprecedented feeling of dread.", film: "The Shining (1980)", tryThis: "Follow a character through three distinct spaces in one tracking shot — let the environment tell the story.", icon: "🎬" },
  { id: "sh6", cat: "Shot", title: "The Dutch Angle", desc: "Tilting the camera off its horizontal axis to create unease and disorientation. Used sparingly, it signals that something is wrong. 'The Third Man' uses it throughout to reflect the moral corruption of post-war Vienna.", film: "The Third Man (1949)", tryThis: "Tilt your camera 15° in a scene where a character is lying. See how it subconsciously signals deception.", icon: "🎬" },
  { id: "sh7", cat: "Shot", title: "The Smash Cut", desc: "An abrupt, jarring transition from one scene to another — often from calm to chaos or silence to noise. Used to shock the viewer. '2001: A Space Odyssey' famously smash cuts from a bone thrown in the air to a space station.", film: "2001: A Space Odyssey (1968)", tryThis: "Cut from absolute silence to the loudest moment in your film. Make the audience physically react.", icon: "🎬" },

  // SOUND
  { id: "so1", cat: "Sound", title: "The Sound Bridge", desc: "Audio from the next scene begins before the visual cut, pulling the audience forward in time. This creates seamless, almost hypnotic transitions. Coppola uses this throughout 'Apocalypse Now' to blur reality and memory.", film: "Apocalypse Now (1979)", tryThis: "In your next edit, start the audio of scene B while still showing scene A. Notice how it smooths time.", icon: "🔊" },
  { id: "so2", cat: "Sound", title: "Diegetic vs. Non-Diegetic Blur", desc: "Blurring the line between sounds that exist in the story world and the score. In 'Baby Driver,' the entire world syncs to the protagonist's music, making it impossible to tell where reality ends and soundtrack begins.", film: "Baby Driver (2017)", tryThis: "Have a character put on headphones — transition the score into what they hear. Make the audience live inside their head.", icon: "🔊" },
  { id: "so3", cat: "Sound", title: "The Power of Silence", desc: "Removing all sound at a critical moment creates more impact than any explosion. In 'No Country for Old Men,' the Coens strip away the score entirely — the silence becomes a character, amplifying every footstep and breath.", film: "No Country for Old Men (2007)", tryThis: "Remove ALL sound for 5 seconds at the peak of a tense scene. Let the silence hit harder than any sound could.", icon: "🔊" },
  { id: "so4", cat: "Sound", title: "Foley Storytelling", desc: "Using carefully crafted everyday sounds to tell the story. The crunch of gravel, the drip of water, the scratch of a pen — each sound is a narrative choice. 'A Quiet Place' made every Foley sound a matter of life and death.", film: "A Quiet Place (2018)", tryThis: "Record a scene using ONLY Foley — no dialogue, no music. Tell the entire story through environmental sounds.", icon: "🔊" },
  { id: "so5", cat: "Sound", title: "Leitmotif", desc: "A recurring musical theme tied to a character, place, or idea. When it plays, even subtly, the audience subconsciously feels that association. John Williams' Imperial March instantly evokes Darth Vader's presence, even off-screen.", film: "Star Wars: The Empire Strikes Back (1980)", tryThis: "Compose a simple 4-note motif for your protagonist. Weave it into three different scenes with different arrangements.", icon: "🔊" },
  { id: "so6", cat: "Sound", title: "Contrapuntal Sound", desc: "Pairing visuals with deliberately contrasting music to create irony, horror, or dark humor. Kubrick scored ultraviolence with classical music in 'A Clockwork Orange,' making the juxtaposition unbearable.", film: "A Clockwork Orange (1971)", tryThis: "Score a violent or dark scene with a cheerful children's song. Feel how it multiplies the horror.", icon: "🔊" },

  // COLOR
  { id: "c1", cat: "Color", title: "The Orange and Teal Look", desc: "The most dominant color grading trend in modern cinema. Warm skin tones against cool blue backgrounds create visual pop and separation. Michael Bay popularized it, but it now appears in everything from Marvel to indie dramas.", film: "Transformers (2007) / Mad Max: Fury Road (2015)", tryThis: "Grade a scene pushing skin tones warm and shadows cool. Notice how subjects instantly pop from backgrounds.", icon: "🎨" },
  { id: "c2", cat: "Color", title: "Desaturation for Realism", desc: "Stripping color creates a documentary feel and emotional weight. Spielberg desaturated 'Saving Private Ryan' to near-monochrome, making the violence feel historical and uncomfortably real.", film: "Saving Private Ryan (1998)", tryThis: "Take a colorful scene and progressively desaturate it. Find the exact point where it shifts from 'pretty' to 'real.'", icon: "🎨" },
  { id: "c3", cat: "Color", title: "Color as Character Arc", desc: "Using color palette shifts to mirror a character's journey. In 'Breaking Bad,' Walter White's wardrobe shifts from beige to black as he transforms from teacher to kingpin — every color choice is deliberate.", film: "Breaking Bad (2008–2013)", tryThis: "Plan a character's wardrobe across three scenes: start neutral, shift to a bold color as they transform.", icon: "🎨" },
  { id: "c4", cat: "Color", title: "The Monochromatic Palette", desc: "Restricting the frame to variations of a single color creates a hypnotic, dreamlike quality. 'The Grand Budapest Hotel' uses precise pastel pinks to build an entire world that feels like a fading postcard.", film: "The Grand Budapest Hotel (2014)", tryThis: "Limit your next scene to one dominant color. Dress the set, wardrobe, and grade everything to match.", icon: "🎨" },
  { id: "c5", cat: "Color", title: "Complementary Color Tension", desc: "Placing complementary colors (opposites on the color wheel) in the same frame creates visual tension and energy. Wes Anderson and Zhang Yimou use red and green, or gold and blue, to create frames that vibrate with life.", film: "Hero (2002)", tryThis: "Design a frame using only two complementary colors. Remove everything else. See how it focuses the eye.", icon: "🎨" },

  // LENS
  { id: "l1", cat: "Lens", title: "Wide Angle Distortion", desc: "Wide lenses (below 24mm) exaggerate depth and distort edges, making close objects loom large and distant ones feel far away. Deakins used wide angles in 'No Country for Old Men' to emphasize the vast, empty Texas landscape as a character.", film: "No Country for Old Men (2007)", tryThis: "Shoot a portrait at 16mm from very close. Notice how it distorts features and creates unease.", icon: "🔭" },
  { id: "l2", cat: "Lens", title: "Shallow Depth of Field", desc: "Using a wide aperture to blur everything except the subject, isolating them from the world. This creates intimacy and directs the viewer's eye precisely. Wong Kar-wai uses it to make his characters feel romantically adrift.", film: "In the Mood for Love (2000)", tryThis: "Shoot at the widest aperture your lens allows. Rack focus between two characters to shift power in a conversation.", icon: "🔭" },
  { id: "l3", cat: "Lens", title: "Anamorphic Lens Flares", desc: "Anamorphic lenses create horizontal blue streaks when light hits the glass, adding a cinematic, almost ethereal quality. J.J. Abrams pushed this to the extreme in 'Star Trek,' using flares as a stylistic signature.", film: "Star Trek (2009) / Blade Runner 2049 (2017)", tryThis: "Shine a light source just off-frame into an anamorphic or vintage lens. Let the flare become part of the composition.", icon: "🔭" },
  { id: "l4", cat: "Lens", title: "The Long Lens Compression", desc: "Telephoto lenses (85mm+) compress depth, stacking elements flat and making distant objects appear closer. This creates claustrophobia and tension. Kurosawa used long lenses to flatten samurai battles into painterly compositions.", film: "Ran (1985)", tryThis: "Shoot two people talking from far away with a 200mm lens. Notice how the flattened space changes their relationship.", icon: "🔭" },
  { id: "l5", cat: "Lens", title: "The Macro Lens World", desc: "Extreme close-up lenses reveal a hidden universe in tiny details — the texture of skin, the surface of water, the mechanics of a watch. Terrence Malick uses macro shots to find cosmic beauty in the smallest things.", film: "The Tree of Life (2011)", tryThis: "Shoot 10 macro shots of everyday objects. Find the one that looks like it could be a planet or a painting.", icon: "🔭" },

  // FRAMING
  { id: "f1", cat: "Framing", title: "The Frame Within a Frame", desc: "Using doors, windows, mirrors, or architectural elements to create a second frame inside the camera's frame. This adds depth and can trap or isolate characters. Kubrick used doorways obsessively to create frames within frames.", film: "Barry Lyndon (1975)", tryThis: "Compose every shot in a scene through doorways, windows, or arches. Never show a character in open space.", icon: "📐" },
  { id: "f2", cat: "Framing", title: "Negative Space", desc: "Leaving large empty areas in the frame to create loneliness, vulnerability, or anticipation. The emptiness itself becomes a storytelling tool. 'Lost in Translation' uses vast empty hotel rooms to visualize emotional isolation.", film: "Lost in Translation (2003)", tryThis: "Place your character in the bottom corner of a wide frame. Leave 70% of the frame empty. Feel the loneliness.", icon: "📐" },
  { id: "f3", cat: "Framing", title: "Symmetrical Composition", desc: "Perfectly centered, symmetrical frames create a sense of order, control, or obsession. Wes Anderson made this his signature — every frame is a precisely balanced dollhouse of visual information.", film: "The Grand Budapest Hotel (2014)", tryThis: "Compose a scene with perfect symmetry. Then break it with one asymmetrical element. Notice what draws the eye.", icon: "📐" },
  { id: "f4", cat: "Framing", title: "The Over-the-Shoulder Shot", desc: "Framing a conversation with one character's shoulder in the foreground creates intimacy and spatial relationship. Varying the size of the shoulder can shift power dynamics — a larger shoulder makes that character feel dominant.", film: "The Social Network (2010)", tryThis: "In a dialogue scene, make one character's shoulder progressively larger in the frame as they gain power in the argument.", icon: "📐" },
  { id: "f5", cat: "Framing", title: "Leading Lines", desc: "Using natural lines in the environment — roads, corridors, fences, shadows — to guide the viewer's eye toward the subject. This creates depth and visual flow. Kubrick's hallways are legendary examples of one-point perspective.", film: "The Shining (1980)", tryThis: "Find a corridor, road, or fence line. Place your subject at the vanishing point. Let the lines pull the viewer in.", icon: "📐" },
  { id: "f6", cat: "Framing", title: "Headroom as Emotion", desc: "The space above a character's head in the frame communicates their emotional state. Too much headroom makes them feel small and overwhelmed. Too little makes them feel trapped. Intentional headroom choices are a subtle but powerful tool.", film: "Mr. Robot (2015–2019)", tryThis: "Shoot the same dialogue twice: once with excessive headroom, once with almost none. Compare the emotional impact.", icon: "📐" },

  // BLOCKING
  { id: "b1", cat: "Blocking", title: "The Power Triangle", desc: "Positioning three characters in a triangle within the frame creates dynamic tension and hierarchy. The character at the apex holds the power. Spielberg frequently stages group scenes this way to guide the audience's eye.", film: "Schindler's List (1993)", tryThis: "Stage a three-person scene. Move the 'powerful' character to the triangle's apex. Watch how attention shifts.", icon: "🎭" },
  { id: "b2", cat: "Blocking", title: "Proxemics in Film", desc: "The physical distance between characters communicates their relationship. Intimate (under 18 inches), personal, social, and public distances each tell a different story. Manipulating this distance IS the performance direction.", film: "Marriage Story (2019)", tryThis: "Start two characters far apart. Over the scene, bring them inches apart — or push them further away. Let distance speak.", icon: "🎭" },
  { id: "b3", cat: "Blocking", title: "The Walk and Talk", desc: "Characters walking while talking adds energy, forward momentum, and naturalism. Aaron Sorkin made this his signature in 'The West Wing.' The movement makes exposition feel urgent instead of static.", film: "The West Wing (1999–2006)", tryThis: "Restage a sitting dialogue scene as a walk-and-talk. Notice how the energy and pacing transform completely.", icon: "🎭" },
  { id: "b4", cat: "Blocking", title: "Levels and Height", desc: "Placing characters at different physical heights within a scene — standing vs. sitting, stairs, elevated platforms — creates instant visual power dynamics without a word being spoken.", film: "The Godfather (1972)", tryThis: "In a two-person scene, have one character stand while the other sits. Halfway through, reverse it. Feel the power shift.", icon: "🎭" },
  { id: "b5", cat: "Blocking", title: "The Reveal Through Movement", desc: "Using character or camera movement to reveal something hidden in the frame. A character steps aside to reveal another person, or the camera pans to uncover a crucial detail. The movement IS the storytelling.", film: "Se7en (1995)", tryThis: "Hide a key story element behind a character. Reveal it only when they move. Time it to maximum impact.", icon: "🎭" },

  // VFX
  { id: "v1", cat: "VFX", title: "Invisible VFX", desc: "The best visual effects are the ones you never notice. 'Zodiac' used extensive CGI to recreate 1970s San Francisco — audiences assumed it was all practical. The goal is seamlessness, not spectacle.", film: "Zodiac (2007)", tryThis: "Watch a drama you assumed was VFX-free. Search for its VFX breakdown. Prepare to be shocked.", icon: "✨" },
  { id: "v2", cat: "VFX", title: "Forced Perspective", desc: "A practical, in-camera effect that uses distance and scale to make objects appear larger or smaller than they are. Peter Jackson used this brilliantly to make hobbits appear small next to humans — no CGI needed.", film: "The Lord of the Rings (2001–2003)", tryThis: "Place a small object close to the lens and a person far away. Align them in frame to create an impossible scale.", icon: "✨" },
  { id: "v3", cat: "VFX", title: "The Digital De-Age", desc: "Using AI and CGI to make actors appear decades younger. Scorsese used it throughout 'The Irishman' to span decades with the same actors, sparking debate about the uncanny valley.", film: "The Irishman (2019)", tryThis: "Study how light falls on faces at different ages. The key difference is often skin translucency and micro-shadows.", icon: "✨" },
  { id: "v4", cat: "VFX", title: "Miniature Photography", desc: "Building detailed physical models and filming them to look full-scale. Before CGI, this was how entire worlds were built. Ridley Scott's 'Blade Runner' cityscapes were intricate miniatures shot with smoke and light.", film: "Blade Runner (1982)", tryThis: "Build a simple miniature set from cardboard and household items. Shoot it with shallow depth of field and dramatic lighting.", icon: "✨" },

  // HISTORY
  { id: "h1", cat: "History", title: "The 300 Spartans at Thermopylae", desc: "In 480 BC, 300 Spartan warriors held a narrow coastal pass against an estimated 100,000–300,000 Persian soldiers for three days. King Leonidas knew it was a suicide mission, but their sacrifice bought Greece the time it needed to survive. Their stand became the ultimate symbol of courage against impossible odds.", film: "300 (2006)", tryThis: "Write a scene where a character knowingly walks into a fight they cannot win — make us understand why they do it anyway.", icon: "⚔️" },
  { id: "h2", cat: "History", title: "The Sinking of the Titanic", desc: "On April 15, 1912, the 'unsinkable' Titanic struck an iceberg and went down in 2 hours and 40 minutes. The band played as the ship sank. Wealthy men gave up lifeboat seats. Couples chose to die together rather than separate. 1,517 people perished in the freezing Atlantic.", film: "Titanic (1997)", tryThis: "Write a scene set in the final 10 minutes before a disaster. Focus on two strangers who must decide: save themselves or help someone else.", icon: "⚔️" },
  { id: "h3", cat: "History", title: "The Speech That Saved Britain", desc: "In June 1940, with France falling and Britain standing alone against Nazi Germany, Winston Churchill delivered 'We shall fight on the beaches.' He offered nothing but 'blood, toil, tears, and sweat.' His words transformed a terrified nation into one that refused to surrender.", film: "Darkest Hour (2017)", tryThis: "Write a speech for a leader who has no good news — only the truth and a reason to keep fighting.", icon: "⚔️" },
  { id: "h4", cat: "History", title: "The Moonshot", desc: "On July 20, 1969, Neil Armstrong and Buzz Aldrin walked on the Moon while Michael Collins orbited alone above. The entire mission ran on less computing power than a modern calculator. 600 million people watched live. It remains humanity's greatest 'we actually did it' moment.", film: "First Man (2018)", tryThis: "Write a scene about the loneliest person in a triumphant moment — the one left behind while others celebrate.", icon: "⚔️" },
  { id: "h5", cat: "History", title: "The Escape from Alcatraz", desc: "In June 1962, Frank Morris and the Anglin brothers escaped the inescapable Alcatraz prison using sharpened spoons, raincoats turned into a raft, and fake heads made of soap and hair to fool guards. They were never found — dead or alive.", film: "Escape from Alcatraz (1979)", tryThis: "Write a heist or escape scene where the plan relies on one absurdly simple, overlooked detail.", icon: "⚔️" },
  { id: "h6", cat: "History", title: "The Christmas Truce of 1914", desc: "On Christmas Eve 1914, German and British soldiers in the trenches of WWI spontaneously stopped fighting. They sang carols, shared cigarettes, and played football in no man's land. The next day, they went back to killing each other. It never happened again at that scale.", film: "Joyeux Noël (2005)", tryThis: "Write a scene where two enemies share one genuine human moment — then must return to being enemies.", icon: "⚔️" },
  { id: "h7", cat: "History", title: "The Chernobyl Divers", desc: "In 1986, three engineers — Alexei Ananenko, Valeri Bezpalov, and Boris Baranov — volunteered to wade through radioactive water beneath the melting Chernobyl reactor to open drainage valves. If they failed, a steam explosion could have made much of Europe uninhabitable. They succeeded.", film: "Chernobyl (2019)", tryThis: "Write a scene where a character volunteers for something no one should survive. Focus on the quiet moment before they go.", icon: "⚔️" },
  { id: "h8", cat: "History", title: "The Fall of the Berlin Wall", desc: "On November 9, 1989, a confused press conference accidentally announced that East Germans could cross freely. Thousands rushed to the wall. Border guards, overwhelmed and without orders, simply opened the gates. Families separated for 28 years embraced in the streets.", film: "The Lives of Others (2006)", tryThis: "Write a scene where a massive historical change happens because of one small human error — and it turns out to be beautiful.", icon: "⚔️" },
  { id: "h9", cat: "History", title: "Shackleton's Endurance Expedition", desc: "In 1915, Ernest Shackleton's ship 'Endurance' was crushed by Antarctic ice, stranding 27 men. Over 2 years, Shackleton kept every single person alive through starvation, frozen oceans, and an 800-mile open-boat journey across the most dangerous seas on Earth. Not one man died.", film: "The Endurance (2000)", tryThis: "Write a survival story where the leader's only weapon is the ability to keep people believing they'll make it.", icon: "⚔️" },
  { id: "h10", cat: "History", title: "The Samurai's Last Stand", desc: "In 1877, Saigō Takamori led the last samurai rebellion against Japan's modernizing army. Armed with swords against cannons and Gatling guns, they fought knowing their era was over. Saigō died on the battlefield, becoming a legend — the embodiment of honor in a world that had moved on.", film: "The Last Samurai (2003)", tryThis: "Write a scene where a character fights for something they know is already lost — not to win, but because it's who they are.", icon: "⚔️" },
];

const CATEGORIES = ["All", "Story", "Shot", "Sound", "Color", "Lens", "Framing", "Blocking", "VFX", "History"];
const CAT_COLORS = {
  Story: { bg: "rgba(255,107,107,0.15)", border: "#ff6b6b", text: "#ff6b6b" },
  Shot: { bg: "rgba(78,205,196,0.15)", border: "#4ecdc4", text: "#4ecdc4" },
  Sound: { bg: "rgba(169,132,255,0.15)", border: "#a984ff", text: "#a984ff" },
  Color: { bg: "rgba(255,190,11,0.15)", border: "#ffbe0b", text: "#ffbe0b" },
  Lens: { bg: "rgba(72,191,227,0.15)", border: "#48bfe3", text: "#48bfe3" },
  Framing: { bg: "rgba(255,150,113,0.15)", border: "#ff9671", text: "#ff9671" },
  Blocking: { bg: "rgba(248,120,172,0.15)", border: "#f878ac", text: "#f878ac" },
  VFX: { bg: "rgba(0,245,160,0.15)", border: "#00f5a0", text: "#00f5a0" },
  History: { bg: "rgba(255,200,87,0.15)", border: "#ffc857", text: "#ffc857" },
};

const STORAGE_KEY = "filmcraft-saved-cards";

export default function FilmCraftDaily() {
  const [activeCat, setActiveCat] = useState("All");
  const [currentIdx, setCurrentIdx] = useState(0);
  const [saved, setSaved] = useState({});
  const [view, setView] = useState("explore"); // explore | saved
  const [flipped, setFlipped] = useState(false);
  const [animDir, setAnimDir] = useState(null);
  const [seen, setSeen] = useState(new Set());
  const [loaded, setLoaded] = useState(false);

  const filtered = activeCat === "All" ? CARDS : CARDS.filter(c => c.cat === activeCat);

  useEffect(() => {
    (async () => {
      try {
        const res = await window.storage.get(STORAGE_KEY);
        if (res && res.value) setSaved(JSON.parse(res.value));
      } catch {}
      setLoaded(true);
    })();
  }, []);

  useEffect(() => {
    if (loaded) {
      window.storage.set(STORAGE_KEY, JSON.stringify(saved)).catch(() => {});
    }
  }, [saved, loaded]);

  useEffect(() => {
    setCurrentIdx(0);
    setFlipped(false);
  }, [activeCat]);

  const card = filtered[currentIdx % filtered.length];
  const isSaved = card && saved[card.id];

  const nextCard = useCallback((dir = 1) => {
    setAnimDir(dir > 0 ? "left" : "right");
    setFlipped(false);
    setTimeout(() => {
      setCurrentIdx(i => {
        const next = (i + dir + filtered.length) % filtered.length;
        if (filtered[next]) setSeen(p => new Set([...p, filtered[next].id]));
        return next;
      });
      setAnimDir(null);
    }, 250);
  }, [filtered]);

  const toggleSave = () => {
    setSaved(prev => {
      const next = { ...prev };
      if (next[card.id]) delete next[card.id];
      else next[card.id] = { ...card, savedAt: Date.now() };
      return next;
    });
  };

  const savedCards = Object.values(saved).sort((a, b) => (b.savedAt || 0) - (a.savedAt || 0));

  const totalSeen = seen.size;
  const totalCards = CARDS.length;

  // Swipe handling
  const touchStart = useRef(null);
  const onTouchStart = e => { touchStart.current = e.touches[0].clientX; };
  const onTouchEnd = e => {
    if (touchStart.current === null) return;
    const diff = e.changedTouches[0].clientX - touchStart.current;
    if (Math.abs(diff) > 50) nextCard(diff < 0 ? 1 : -1);
    touchStart.current = null;
  };

  const colors = card ? CAT_COLORS[card.cat] : {};

  return (
    <div style={{ minHeight: "100vh", background: "linear-gradient(160deg, #0a0a0f 0%, #111127 40%, #0d0d1a 100%)", color: "#e8e8f0", fontFamily: "'Inter', -apple-system, system-ui, sans-serif", overflow: "hidden" }}>
      {/* Header */}
      <div style={{ padding: "20px 20px 0", display: "flex", alignItems: "center", justifyContent: "space-between" }}>
        <div>
          <h1 style={{ margin: 0, fontSize: 26, fontWeight: 800, background: "linear-gradient(135deg, #ff6b6b, #ffc857, #4ecdc4)", WebkitBackgroundClip: "text", WebkitTextFillColor: "transparent" }}>Film Craft Daily</h1>
          <p style={{ margin: "2px 0 0", fontSize: 12, color: "#666", letterSpacing: 2, textTransform: "uppercase" }}>Sharpen Your Cinematic Eye</p>
        </div>
        <div style={{ display: "flex", gap: 6, alignItems: "center" }}>
          <div style={{ fontSize: 11, color: "#555", marginRight: 4 }}>{totalSeen}/{totalCards}</div>
          <div style={{ width: 60, height: 4, background: "#1a1a2e", borderRadius: 2, overflow: "hidden" }}>
            <div style={{ width: `${(totalSeen / totalCards) * 100}%`, height: "100%", background: "linear-gradient(90deg, #4ecdc4, #ff6b6b)", borderRadius: 2, transition: "width 0.5s" }} />
          </div>
        </div>
      </div>

      {/* View Toggle */}
      <div style={{ display: "flex", margin: "16px 20px 0", background: "#12122a", borderRadius: 12, padding: 3 }}>
        {["explore", "saved"].map(v => (
          <button key={v} onClick={() => setView(v)} style={{
            flex: 1, padding: "10px 0", border: "none", borderRadius: 10, fontSize: 13, fontWeight: 600, cursor: "pointer", transition: "all 0.3s",
            background: view === v ? "linear-gradient(135deg, rgba(255,107,107,0.2), rgba(78,205,196,0.2))" : "transparent",
            color: view === v ? "#fff" : "#555",
          }}>
            {v === "explore" ? `✦ Explore` : `♡ Saved (${savedCards.length})`}
          </button>
        ))}
      </div>

      {view === "explore" ? (
        <>
          {/* Category Chips */}
          <div style={{ display: "flex", gap: 8, padding: "16px 20px", overflowX: "auto", scrollbarWidth: "none" }}>
            {CATEGORIES.map(cat => {
              const active = activeCat === cat;
              const catColor = cat === "All" ? { border: "#888", text: "#888", bg: "rgba(136,136,136,0.1)" } : CAT_COLORS[cat];
              return (
                <button key={cat} onClick={() => setActiveCat(cat)} style={{
                  flexShrink: 0, padding: "7px 16px", borderRadius: 20, fontSize: 12, fontWeight: 600, cursor: "pointer", transition: "all 0.3s", whiteSpace: "nowrap",
                  border: `1.5px solid ${active ? catColor.border : "transparent"}`,
                  background: active ? catColor.bg : "rgba(255,255,255,0.04)",
                  color: active ? catColor.text : "#555",
                }}>
                  {cat}
                </button>
              );
            })}
          </div>

          {/* Card */}
          {card && (
            <div style={{ padding: "8px 20px 20px", perspective: 1200 }}
              onTouchStart={onTouchStart} onTouchEnd={onTouchEnd}>
              <div onClick={() => setFlipped(!flipped)} style={{
                position: "relative", cursor: "pointer",
                transformStyle: "preserve-3d", transition: "transform 0.5s cubic-bezier(0.4,0,0.2,1)",
                transform: `${flipped ? "rotateY(180deg)" : "rotateY(0)"} ${animDir === "left" ? "translateX(-120%) rotate(-8deg)" : animDir === "right" ? "translateX(120%) rotate(8deg)" : "translateX(0)"}`,
                opacity: animDir ? 0 : 1,
              }}>
                {/* Front */}
                <div style={{
                  backfaceVisibility: "hidden",
                  background: `linear-gradient(145deg, ${colors.bg || '#1a1a2e'}, #0d0d1a)`,
                  border: `1px solid ${colors.border || '#333'}22`,
                  borderRadius: 20, padding: "28px 24px", minHeight: 380,
                  boxShadow: `0 8px 40px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.05)`,
                }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: 16 }}>
                    <span style={{ fontSize: 11, fontWeight: 700, letterSpacing: 2, textTransform: "uppercase", color: colors.text, opacity: 0.8 }}>
                      {card.icon} {card.cat}
                    </span>
                    <span style={{ fontSize: 11, color: "#444" }}>
                      {(filtered.indexOf(card) + 1)}/{filtered.length}
                    </span>
                  </div>
                  <h2 style={{ fontSize: 24, fontWeight: 800, margin: "0 0 16px", lineHeight: 1.2, color: "#fff" }}>{card.title}</h2>
                  <p style={{ fontSize: 14, lineHeight: 1.7, color: "#b0b0c8", margin: "0 0 20px" }}>{card.desc}</p>
                  <div style={{ background: "rgba(255,255,255,0.04)", borderRadius: 12, padding: "12px 16px", marginBottom: 16 }}>
                    <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1.5, textTransform: "uppercase", color: "#555" }}>Featured In</span>
                    <p style={{ margin: "4px 0 0", fontSize: 14, fontWeight: 600, color: colors.text }}>{card.film}</p>
                  </div>
                  <p style={{ fontSize: 11, color: "#444", margin: 0, textAlign: "center" }}>Tap to see your challenge →</p>
                </div>

                {/* Back */}
                <div style={{
                  position: "absolute", top: 0, left: 0, right: 0,
                  backfaceVisibility: "hidden", transform: "rotateY(180deg)",
                  background: `linear-gradient(145deg, #0d0d1a, ${colors.bg || '#1a1a2e'})`,
                  border: `1px solid ${colors.border || '#333'}22`,
                  borderRadius: 20, padding: "28px 24px", minHeight: 380,
                  boxShadow: `0 8px 40px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.05)`,
                  display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center",
                }}>
                  <span style={{ fontSize: 40, marginBottom: 16 }}>🎬</span>
                  <span style={{ fontSize: 11, fontWeight: 700, letterSpacing: 2, textTransform: "uppercase", color: colors.text, marginBottom: 12 }}>Try This</span>
                  <p style={{ fontSize: 16, lineHeight: 1.8, color: "#d0d0e8", textAlign: "center", maxWidth: 340, margin: 0 }}>{card.tryThis}</p>
                  <p style={{ fontSize: 11, color: "#444", margin: "20px 0 0", textAlign: "center" }}>Tap to flip back</p>
                </div>
              </div>
            </div>
          )}

          {/* Controls */}
          <div style={{ display: "flex", justifyContent: "center", gap: 16, padding: "8px 20px 30px" }}>
            <button onClick={() => nextCard(-1)} style={{
              width: 52, height: 52, borderRadius: "50%", border: "1px solid #222", background: "rgba(255,255,255,0.03)",
              color: "#666", fontSize: 20, cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", transition: "all 0.2s",
            }}>←</button>
            <button onClick={toggleSave} style={{
              width: 52, height: 52, borderRadius: "50%", border: `1.5px solid ${isSaved ? "#ff6b6b" : "#222"}`,
              background: isSaved ? "rgba(255,107,107,0.15)" : "rgba(255,255,255,0.03)",
              color: isSaved ? "#ff6b6b" : "#666", fontSize: 22, cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", transition: "all 0.3s",
            }}>{isSaved ? "♥" : "♡"}</button>
            <button onClick={() => nextCard(1)} style={{
              width: 52, height: 52, borderRadius: "50%", border: "1px solid #222", background: "rgba(255,255,255,0.03)",
              color: "#666", fontSize: 20, cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", transition: "all 0.2s",
            }}>→</button>
          </div>
        </>
      ) : (
        /* SAVED VIEW */
        <div style={{ padding: "12px 20px 30px" }}>
          {savedCards.length === 0 ? (
            <div style={{ textAlign: "center", padding: "60px 20px", color: "#444" }}>
              <span style={{ fontSize: 48 }}>♡</span>
              <p style={{ fontSize: 15, marginTop: 12 }}>No saved cards yet</p>
              <p style={{ fontSize: 12, color: "#333" }}>Tap the heart while exploring to save cards here</p>
            </div>
          ) : (
            <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
              {savedCards.map(sc => {
                const c = CAT_COLORS[sc.cat] || {};
                return (
                  <div key={sc.id} style={{
                    background: `linear-gradient(145deg, ${c.bg || '#1a1a2e'}, #0d0d1a)`,
                    border: `1px solid ${c.border || '#333'}18`,
                    borderRadius: 16, padding: "18px 20px",
                    boxShadow: "0 4px 20px rgba(0,0,0,0.3)",
                  }}>
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                      <div style={{ flex: 1 }}>
                        <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1.5, textTransform: "uppercase", color: c.text, opacity: 0.7 }}>
                          {sc.icon} {sc.cat}
                        </span>
                        <h3 style={{ margin: "6px 0 8px", fontSize: 16, fontWeight: 700, color: "#fff" }}>{sc.title}</h3>
                        <p style={{ margin: 0, fontSize: 12, lineHeight: 1.6, color: "#888", display: "-webkit-box", WebkitLineClamp: 2, WebkitBoxOrient: "vertical", overflow: "hidden" }}>{sc.desc}</p>
                        <p style={{ margin: "8px 0 0", fontSize: 11, color: c.text, fontWeight: 600 }}>{sc.film}</p>
                      </div>
                      <button onClick={() => {
                        setSaved(prev => { const next = { ...prev }; delete next[sc.id]; return next; });
                      }} style={{
                        background: "none", border: "none", color: "#ff6b6b", fontSize: 18, cursor: "pointer", padding: "0 0 0 12px", flexShrink: 0,
                      }}>♥</button>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}
    </div>
  );
}