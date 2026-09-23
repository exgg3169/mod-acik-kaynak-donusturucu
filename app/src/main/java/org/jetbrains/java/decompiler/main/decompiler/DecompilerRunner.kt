package org.jetbrains.java.decompiler.main.decompiler

import org.jetbrains.java.decompiler.main.extern.IFernflowerLogger
import java.io.File

/**
 * Vineflower's [ConsoleDecompiler] constructor is `protected`, so it can only be
 * reached from a subclass (or from code in this same package). This thin subclass
 * exists purely to expose it to the rest of the app.
 */
class DecompilerRunner(
    destination: File,
    options: Map<String, Any>,
    logger: IFernflowerLogger
) : ConsoleDecompiler(destination, options, logger)
