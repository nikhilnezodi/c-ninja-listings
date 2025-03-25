MEMORY
{
    RAM : ORIGIN = 0X80000000, LENGTH = 4k
}

SECTIONS
{
.text : {
    *(.text)
    /* *(.nikhil) */
    } > RAM
.nikhil : {
    *(.nikhil)
    } > RAM
}