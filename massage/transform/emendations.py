from constants import *
from . import alt
# from pymei import MeiElement


def emendations(MEI_tree, alternates_list, color_we_want):
    """Uses the list of alternate readings to find the emendations,
    and reorganize the MEI file so that the alternate readings are
    grouped together with the lemma.
    """
    alt.local_alternatives(MEI_tree, alternates_list, color_we_want, EMENDATION)
    sections = MEI_tree.getDescendantsByName('section')
    if len(sections) > 0:
        link_emendations(sections[0])


def link_emendations(section):
    alt.link_alternatives(section, EMENDATION)
