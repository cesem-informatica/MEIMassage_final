from constants import *
from . import alt


def variants(MEI_tree, alternates_list, color_we_want):
    """Uses the list of alternate readings to find the variants,
    and reorganize the MEI file so that the alternate readings are
    grouped together with the lemma.
    """
    alt.local_alternatives(MEI_tree, alternates_list, color_we_want, VARIANT)
    sections = MEI_tree.getDescendantsByName('section')
    if len(sections) > 0:
        link_variants(sections[0])


def link_variants(section):
    alt.link_alternatives(section, VARIANT)
