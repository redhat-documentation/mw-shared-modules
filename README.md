# Shared modules for Red Hat Middleware docs

This repo contains modules that can be shared across Red Hat Middleware product docs.

## Sharing modules

You can share either a single module, or a set of modules that can (or should) be reused together - such as in an assembly. To share a single module or a set of modules:

1. [Prepare the module (or modules) for reuse](#preparing-a-module-for-reuse).
2. [Create a PR for the module (or modules)](#creating-a-pr-to-add-shared-modules).

### Preparing a module for reuse

Before you can share a module, you must prepare it for reuse. This ensures that anyone can quickly see who is using the module, and where they are using it. That way, if the module ever needs to be updated, you can notify the writers whose publications will be affected by the change.

* In the module, add a comment at the top indicating:

  * Your GitHub user name and the book in which the module is used.
  * Any attributes that are used.

  For example:

   ```
   // Module included in the following:
   //
   // @bhardesty - Using AMQ Interconnect
   //
   // Attributes used:

   // {ProductName}
   // {ProductLongName}
   // {ProductCategory}
  ```

### Creating a PR to add shared modules

After preparing the module (or modules) for reuse, you must create a PR to add it to the `mw-shared-modules/modules/` directory in this repository.

1. Create a PR to add the module.

2. Wait. The PR will be reviewed and, once approved, merged.

3. After the PR is merged:

   * Update your book to point to the module. For more information, see [Reusing a shared module](#reusing-a-shared-module).
   * If necessary, notify other Middleware writers about the shared module so that others can use it.

## Updating a shared module

Making a change to a shared module impacts every book in which the module is used. Therefore, communication is important.

1. Create a PR with your updates.

2. In the PR, tag each writer who is listed in the comments in the beginning of the module.

3. Wait. Make sure that all affected writers have an opportunity to review your changes and determine how to implement the updated module in their books.

## Reusing a shared module

While there are many possible ways to reuse a shared module stored in this repo, this procedure describes one particular method that uses *remote includes*.

A remote include is an AsciiDoc include directive in which the target points to a URL. By using a remote include, you can reuse any of the shared modules stored in this repo by referencing the URL of the module. You do not need to clone this repo or copy any files.

However, remote includes present a limitation: Asciidoctor only enables remote includes when running in lower security modes than what CCS tooling requires. Therefore, to use a remote include to include a shared module in your assembly, you must perform an extra step to coalesce the content from the assembly into a second AsciiDoc file, which can then be processed properly by CCS tooling.

To reuse a shared module by using a remote include:

1. In the assembly in which the module should be used, include the module using the URL of the module's location. For example, to point to the _What operators are_ module:

   ```
   include::https://raw.githubusercontent.com/redhat-documentation/mw-shared-modules/master/modules/what-operators-are.adoc[leveloffset=+1]
   ```

2. If the shared module uses any attributes, define them in the assembly in which you included the module.

   For example, say the shared module uses an attribute called `:ProdName:` to represent the product name, but your book already uses a different attribute (say, `:ProductName:`) for the same thing. To use the shared module, you would add `:ProdName:` and set it to the value of `:ProductName:`:

   ```
   :ProdName: {ProductName}
   include::https://raw.githubusercontent.com/redhat-documentation/mw-shared-modules/master/modules/what-operators-are.adoc[leveloffset=+1]
   ```   

3. Run `getRemote.sh` to resolve the remote includes and create a new assembly with all of the content.

   This script uses `asciidoc-coalescer` to process the assembly in which you added the remote include to the shared module(s), resolves the include directives, and creates a separate AsciiDoc file with all of the content.

   For example, this command coalesces the content in `my-assembly.adoc` and creates a new combined assembly in the same directory (`my-assembly-combined.adoc`):

   ```
   mw-shared-modules/scripts/getRemote.sh my-assembly.adoc
   ```

   **NOTE:** Do not edit the combined assembly. If you need to make changes, edit the original assembly and then use `getRemote.sh` to re-create the combined assembly.

4. To use the assembly in your book, include the combined assembly in your book's `master.adoc` file.

   **NOTE:** You must include the combined assembly that was created by `getRemote.sh`, *not* the original assembly in which you added the remote include.
