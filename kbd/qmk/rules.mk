ACHORDION_ENABLE ?= yes
ifeq ($(strip $(ACHORDION_ENABLE)), yes)
	OPT_DEFS += -DACHORDION_ENABLE
	SRC += features/achordion.c
endif
