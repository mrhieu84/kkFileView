! function(e) {
    var t = {};

    function n(r) {
        if (t[r]) return t[r].exports;
        var o = t[r] = {
            i: r,
            l: !1,
            exports: {}
        };
        return e[r].call(o.exports, o, o.exports, n), o.l = !0, o.exports
    }
    n.m = e, n.c = t, n.d = function(e, t, r) {
        n.o(e, t) || Object.defineProperty(e, t, {
            enumerable: !0,
            get: r
        })
    }, n.r = function(e) {
        "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(e, "__esModule", {
            value: !0
        })
    }, n.t = function(e, t) {
        if (1 & t && (e = n(e)), 8 & t) return e;
        if (4 & t && "object" == typeof e && e && e.__esModule) return e;
        var r = Object.create(null);
        if (n.r(r), Object.defineProperty(r, "default", {
                enumerable: !0,
                value: e
            }), 2 & t && "string" != typeof e)
            for (var o in e) n.d(r, o, function(t) {
                return e[t]
            }.bind(null, o));
        return r
    }, n.n = function(e) {
        var t = e && e.__esModule ? function() {
            return e.default
        } : function() {
            return e
        };
        return n.d(t, "a", t), t
    }, n.o = function(e, t) {
        return Object.prototype.hasOwnProperty.call(e, t)
    }, n.p = "", n(n.s = 3)
}({
    3: function(e, t, n) {
        "use strict";
        n.r(t);
        const r = {
            toolbar: {
               undo: "undo",
                redo: "restore",
                print: "print",
                paintformat: "Format Paint",
                clearformat: "clear format",
                format: "data format",
                fontName: "Font",
                fontSize: "font size",
                fontBold: "Bold",
                fontItalic: "tilt",
                underline: "underline",
                strike: "strikethrough",
                color: "Font color",
                bgcolor: "fill color",
                border: "border",
                merge: "Merge cells",
                align: "Horizontal alignment",
                valign: "Vertical alignment",
                textwrap: "Automatic line wrapping",
                freeze: "freeze",
                autofilter: "Auto filter",
                formula: "function",
                more: "more"
            },
            contextmenu: {
                copy: "copy",
                cut: "cut",
                paste: "paste",
                pasteValue: "Paste data",
                pasteFormat: "paste format",
                hide: "hide",
                insertRow: "Insert row",
                insertColumn: "Insert column",
                deleteSheet: "delete",
                deleteRow: "Delete row",
                deleteColumn: "Delete column",
                deleteCell: "delete",
                deleteCellText: "Delete data",
                validation: "data validation",
                cellprintable: "printable",
                cellnonprintable: "not printable",
                celleditable: "editable",
                cellnoneditable: "Not editable"
            },
            print: {
              size: "paper size",
                orientation: "direction",
                orientations: ["landscape", "portrait"]
            },
            format: {
               normal: "normal",
                text: "text",
                number: "numeric value",
                percent: "Percent",
                rmb: "RMB",
                usd: "USD",
                eur: "Euro",
                date: "short date",
                time: "time",
                datetime: "long date",
                duration: "duration"
            },
            formula: {
                sum: "Sum",
                average: "find the average",
                max: "Find the maximum value",
                min: "Find the minimum value",
                concat: "Character concatenation",
                _if: "Conditional judgment",
                and: "and",
                or: "or"
            },
            validation: {
               required: "This value is required",
                notMatch: "This value does not match the validation rule",
                between: "This value should be between {} and {}",
                notBetween: "This value should not be between {} and {}",
                notIn: "This value is not in the list",
                equal: "This value should be equal to {}",
                notEqual: "This value should not be equal to {}",
                lessThan: "This value should be less than {}",
                lessThanEqual: "This value should be less than or equal to {}",
                greaterThan: "This value should be greater than {}",
                greaterThanEqual: "This value should be greater than or equal to {}"
            },
            error: {
                pasteForMergedCell: "This operation cannot be performed on merged cells"
            },
            calendar: {
              weeks: ["day", "one", "two", "three", "Four", "five", "six"],
                months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October" ,"Month", "November", "December"]
            },
            button: {
               next: "Next step",
                cancel: "cancel",
                remove: "delete",
                save: "save",
                ok: "confirm"
            },
            sort: {
                desc: "descending order",
                asc: "Ascending order"
            },
            filter: {
                empty: "blank"
            },
            dataValidation: {
                mode: "model",
                range: "unit interval",
                criteria: "condition",
                modeType: {
                    cell: "cell",
                    column: "column mode",
                    row: "row mode"
                },
                type: {
                    list: "list",
                    number: "number",
                    date: "date",
                    phone: "Mobile phone number",
                    email: "email"
                },
                operator: {
                 be: "in the range",
                    nbe: "Not in the range",
                    lt: "less than",
                    lte: "less than or equal to",
                    gt: "greater than",
                    gte: "greater than or equal to",
                    eq: "equal to",
                    neq: "not equal to"
                }
            }
        };
        window && window.x_spreadsheet && (window.x_spreadsheet.$messages = window.x_spreadsheet.$messages || {}, window.x_spreadsheet.$messages["zh-cn"] = r), t.default = r
    }
});