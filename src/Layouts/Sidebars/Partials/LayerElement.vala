/*
 * Copyright (c) 2021 Alecaddd (https://alecaddd.com)
 *
 * This file is part of Akira.
 *
 * Akira is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * Akira is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with Akira. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
 */

/*
 * Layout component containing the layer UI widget, which adapts based on the
 * node's model type (Artboard, Layer, Group).
 */
public class Akira.Layouts.Sidebars.Partials.LayerElement : Gtk.ListBoxRow {
    public unowned Lib.ViewCanvas view_canvas { get; construct; }
    public unowned Lib.Items.ModelInstance node_instance { get; construct; }

    private Gtk.Label label;

    public LayerElement (Lib.Items.ModelInstance node, Lib.ViewCanvas canvas) {
        Object (
            view_canvas: canvas,
            node_instance: node
        );
    }

    ~LayerElement () {}

    construct {
        can_focus = true;

        label = new Gtk.Label ("");
        label.halign = Gtk.Align.FILL;
        label.xalign = 0;
        label.expand = true;
        label.set_ellipsize (Pango.EllipsizeMode.END);

        // Temporarily print the ID just to see something.
        label.label = node_instance.id.to_string ();

        // Build a specific UI based on the node instance's type.
        if (node_instance.type is Lib.Items.ModelTypeArtboard) {
            _build_artboard_ui ();
        } else if (node_instance.type is Lib.Items.ModelTypeGroup) {
            _build_group_ui ();
        } else {
            _build_layer_ui ();
        }

        add (label);
    }

    /*
     * Build the layer UI for the Artboard node.
     */
    private void _build_artboard_ui () {
        get_style_context ().add_class ("artboard");

        label.get_style_context ().add_class ("artboard-name");
    }

    // TODO...
    private void _build_group_ui () {}

    /*
     * Build the layer UI for the generic Layer node.
     */
    private void _build_layer_ui () {
        get_style_context ().add_class ("layer");
    }
}